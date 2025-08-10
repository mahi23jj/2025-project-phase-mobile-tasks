import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../autentication/data/data_source/local_data_source.dart';
import '../../../autentication/data/data_source/local_data_source_imp.dart';
import '../model/chat_model.dart';


// Your Message model import

class WebSocketService {
  // 1. Connection Management
  static const String serverUrl =
      'wss://g5-flutter-learning-path-be-tvum.onrender.com';
  IO.Socket? _socket;
  final LocalUserDataSource _authService;
  final _messageController = StreamController<ChatModel>.broadcast();

Stream<ChatModel> get messageStream => _messageController.stream;

  // 2. Event Callbacks (Observer Pattern)
  Function(ChatModel)? onMessageReceived;
  Function(ChatModel)? onMessageDelivered;
  Function(String)? onMessageError;
  Function()? onConnected;
  Function()? onDisconnected;

  WebSocketService({required LocalUserDataSource authService})
    : _authService = authService;

  Future<void> connect() async {
    try {
      // STEP 1: Get authentication token
      final token = await _authService.gettoken();
      if (token == null) {
        print('No token available for WebSocket connection');
        return;
      }

      // STEP 2: Configure WebSocket connection
      _socket = IO.io(
        serverUrl,
        IO.OptionBuilder()
            .setTransports(['websocket']) // Force WebSocket (not polling)
            .enableAutoConnect() // Auto-reconnect on disconnect
            .setExtraHeaders({
              'Authorization': 'Bearer $token',
            }) // Send auth token
            .build(),
      );

      // STEP 3: Set up connection event listeners
      _socket!.onConnect((_) {
        print('Connected to WebSocket');
        onConnected?.call();
      });

      _socket!.onDisconnect((_) {
        print('Disconnected from WebSocket');
        onDisconnected?.call();
      });

      // STEP 4: Set up message event listeners
      _socket!.on('message:received', (data) {
        try {
          final message = ChatModel.fromJson(data);
          _messageController.add(message);
          onMessageReceived?.call(message);
        } catch (e) {
          print('Error parsing received message: $e');
        }
      });

      _socket!.on('message:delivered', (data) {
        try {
          final message = ChatModel.fromJson(data);
          onMessageDelivered?.call(message);
        } catch (e) {
          print('Error parsing delivered message: $e');
        }
      });

      _socket!.on('message:error', (data) {
        final error = data['error'] ?? 'Unknown error';
        print('Message error: $error');
        onMessageError?.call(error);
      });
    } catch (e) {
      print('WebSocket connection error: $e');
      onMessageError?.call(e.toString());
    }
  }



  void sendMessage(ChatModel message) {
    if (_socket?.connected == true) {
      _socket!.emit('message:send', message.toJson());
    } else {
      print('Socket not connected');
      onMessageError?.call('Not connected to server');
    }
  }

  void joinChat(String chatId) {
    if (_socket?.connected == true) {
      _socket!.emit('chat:join', {'chatId': chatId});
    }
  }

  void disconnect() {
    _socket?.disconnect();
    _socket?.dispose();
    _socket = null;
  }
}

import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../autentication/data/data_source/local_data_source.dart';
import '../model/chat_model.dart';
import '../model/message_model.dart';


// adjust import

class WebSocketService {
  final LocalUserDataSource _authService;
  late IO.Socket _socket;

  bool _isConnected = false;
  Completer<void>? _connectionCompleter;

  static const String socketBaseUrl =
      'https://g5-flutter-learning-path-be-tvum.onrender.com/socket.io/';

  WebSocketService(this._authService);

  Future<void> connect() async {
    if (_isConnected) {
      print('⚠️ Socket already connected');
      return;
    }

    final authToken = await _authService.gettoken();
    print("🔑 Auth token: $authToken");

    _connectionCompleter = Completer<void>();

    _socket = IO.io(
      socketBaseUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableForceNew()
          .enableAutoConnect()
          // You can pass the token either as a query param or header
          // .setQuery({'token': authToken}) // <-- preferred for Socket.IO auth
          // If your backend really expects headers, uncomment:
          .setExtraHeaders({'Authorization': 'Bearer $authToken'})
          .build(),
    );

    _socket.onConnect((_) {
      _isConnected = true;
      print('✅ Socket connected to $socketBaseUrl');
      _connectionCompleter?.complete();
    });

    _socket.onDisconnect((_) {
      _isConnected = false;
      print('❌ Socket disconnected');
    });

    _socket.onReconnect((_) => print('🔄 Socket reconnected'));
    _socket.onReconnectAttempt((_) => print('⏳ Attempting to reconnect...'));
    _socket.onConnectError((err) {
      print('🚨 Socket connection error: $err');
    });
    _socket.onError((err) {
      print('🚨 General socket error: $err');
    });

    // Listen for message delivery
    _socket.on('message:delivered', (data) {
      print('📬 Delivery confirmation: $data');
    });

    // Listen for received messages
    _socket.on('message:received', (data) {
      print('📩 Received message: $data');
    });

    return _connectionCompleter!.future;
  }

  Future<bool> sendMessage({
    required String chatId,
    required String content,
    required String type,
  }) async {
    if (!_isConnected) {
      print('🔴 Socket not connected. Cannot send message.');
      return false;
    }

    try {
      print('📤 Sending message to chatId=$chatId: $content');

      _socket.emit('message:send', {
        'chatId': chatId,
        'content': content,
        'type': type,
      });

      return true;
    } catch (e) {
      print('❌ Exception during emit: $e');
      return false;
    }
  }

  void disconnect() {
    _socket.dispose();
    _isConnected = false;
    print('🔌 Socket disconnected manually');
  }
}



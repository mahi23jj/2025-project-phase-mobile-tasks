import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class WebSocketServicetest {
  IO.Socket? _socket;

  static const String socketBaseUrl =
      'https://g5-flutter-learning-path-be-tvum.onrender.com';

  final _messageCtrl = StreamController<Map<String, dynamic>>.broadcast();

  Stream<Map<String, dynamic>> get messageStream => _messageCtrl.stream;




 final token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFiY0BnbWFpbC5jb20iLCJzdWIiOiI2ODk3NDg4YjUxMGMxMGVlOGQ3NjBmMzAiLCJpYXQiOjE3NTQ5MDU1NDUsImV4cCI6MTc1NTMzNzU0NX0.-09E4BoulsNj91lXgxNuPzcbKGZYBa6aqKxfZxxyXVs';

  // Initialize and connect socket
  // void connect() {
  //   _socket = IO.io(
  //     socketBaseUrl,
      
  //     IO.OptionBuilder()
  //         .setTransports(['websocket']) // for Flutter compatibility
  //         .disableAutoConnect()
  //         .setExtraHeaders({'Authorization': 'Bearer '}) // connect manually
  //         .build(),
  //   );

  //   // Debug listeners
  //   _socket?.on('connect', (_) => print('🔵 Socket connected, id: ${_socket?.id}'));
  //   _socket?.on('disconnect', (_) => print('🔴 Socket disconnected'));
  //   _socket?.on('error', (data) => print('⚠️ Socket error: $data'));
  //   _socket?.on('connect_error', (data) => print('⚠️ Connect error: $data'));

  //   // Example: listen for incoming messages or events from server
  //   _socket?.on('message:receive', (data) {
  //     print('🔔 New message received: $data');
  //     if (data is Map<String, dynamic>) {
  //       _messageCtrl.add(data);
  //     }
  //   });

  //   _socket?.connect();
  // }

  void connect() {
  _socket = IO.io(
    socketBaseUrl,
    IO.OptionBuilder()
        .setTransports(['websocket'])
        .setExtraHeaders({'Authorization': 'Bearer $token'})  // <-- Add auth header here
        .disableAutoConnect()
        .build(),
  );

  // Same debug listeners as before
  _socket?.on('connect', (_) => print('🔵 Socket connected, id: ${_socket?.id}'));
  _socket?.on('disconnect', (_) => print('🔴 Socket disconnected'));
  _socket?.on('error', (data) => print('⚠️ Socket error: $data'));
  _socket?.on('connect_error', (data) => print('⚠️ Connect error: $data'));
  
  _socket?.on('message:received', (data) {
    print('🔔 New message received: $data');
    if (data is Map<String, dynamic>) {
      _messageCtrl.add(data);
    }
  });

  _socket?.connect();
}


  // Send message method
  Future<bool> sendMessage({
    required String chatId,
    required String content,
    required String type,
  }) async {
    if (!(_socket?.connected ?? false)) {
      print('🔴 Socket not connected. Cannot send message.');
      return false;
    }

    try {
      print('📤 Sending message to chatId=$chatId: $content');

      _socket?.emit('message:send', {
        'chatId': chatId,
        'content': content,
        'type': type,
      });

      // Small delay to ensure emit is sent
      await Future.delayed(const Duration(milliseconds: 100));

      print(_socket?.connected);

      return true;
    } catch (e) {
      print('❌ Exception during emit: $e');
      return false;
    }
  }

  // Dispose stream controller when done
  void dispose() {
    _messageCtrl.close();
    _socket?.dispose();
  }
}

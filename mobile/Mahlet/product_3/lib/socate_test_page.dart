import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketTestPage extends StatefulWidget {
  @override
  _SocketTestPageState createState() => _SocketTestPageState();
}

class _SocketTestPageState extends State<SocketTestPage> {
  IO.Socket? _socket;
  final List<String> messages = [];
  bool _isConnected = false;

  // Ensure this URL is correct and handles WebSocket connections
  final String _baseUrl = "https://g5-flutter-learning-path-be-tvum.onrender.com";
  final String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFiY0BnbWFpbC5jb20iLCJzdWIiOiI2ODk3NDg4YjUxMGMxMGVlOGQ3NjBmMzAiLCJpYXQiOjE3NTQ5MDU1NDUsImV4cCI6MTc1NTMzNzU0NX0.-09E4BoulsNj91lXgxNuPzcbKGZYBa6aqKxfZxxyXVs';

  @override
  void initState() {
    super.initState();
    connect();
  }

  void connect() {
    // Dispose of any existing socket connection before creating a new one.
    _socket?.dispose();

    _socket = IO.io(
      _baseUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          // 1. **FIX:** Added a space between 'Bearer' and the token.
          .setExtraHeaders({'Authorization': 'Bearer $token'})
          .disableAutoConnect()
          .build(),
    );

    _socket?.onConnect((_) {
      debugPrint('✅ Socket connected successfully!');
      if (mounted) {
        setState(() {
          _isConnected = true;
          messages.add('✅ Connected to socket');
        });
      }
    });

    _socket?.onConnectError((err) {
      debugPrint('❌ Connection error: $err');
      if (mounted) {
        setState(() {
          _isConnected = false;
          messages.add('❌ Connection error: $err');
        });
      }
    });

    _socket?.onDisconnect((reason) {
      debugPrint('🔌 Socket disconnected: $reason');
      if (mounted) {
        setState(() {
          _isConnected = false;
          messages.add('🔌 Disconnected: $reason');
        });
      }
    });

    _socket?.onError((error) {
      debugPrint('⚠️ Socket error: $error');
      if (mounted) {
        setState(() {
          messages.add('⚠️ Socket error: $error');
        });
      }
    });

    _socket?.on('message:received', (data) {
      debugPrint('📥 New message received: $data');
      if (mounted) {
        setState(() {
          messages.add('📥 Message: $data');
        });
      }
    });

    // Manually initiate the connection.
    _socket?.connect();
  }

  void sendMessage() {
    if (_socket == null || !_isConnected) {
      setState(() {
        messages.add(
          '⚠️ Cannot send message. Socket is not connected.',
        );
      });
      return;
    }

    final messageData = {
      'chatId': '6899c60e817e9a3287ca515f',
      'content': 'Hello from debugenow',
      'type': 'text',
    };

    _socket?.emit('message:send', messageData);


    // 2. **IMPROVEMENT:** UI update is now more explicit about what was sent.
    setState(() {
      messages.add('📤 Sent: ${messageData['content']}');
    });
  }

  @override
  void dispose() {
    _socket?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Socket Test'),
        // 3. **IMPROVEMENT:** Visual indicator for connection status.
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Icon(
              Icons.circle,
              color: _isConnected ? Colors.green : Colors.red,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isConnected ? sendMessage : null,
                    child: const Text('Send Message'),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: connect,
                  child: const Text('Reconnect'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              reverse: true, // 4. **IMPROVEMENT:** Show latest messages at the bottom.
              itemCount: messages.length,
              itemBuilder: (_, index) {
                // To display in correct order with reverse: true
                final message = messages[messages.length - 1 - index];
                return ListTile(title: Text(message));
              },
            ),
          ),
        ],
      ),
    );
  }
}
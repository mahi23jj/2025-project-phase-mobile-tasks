import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/Entity/chat_message_Entity.dart';
import '../Bloc/chat_bloc.dart';
import '../Bloc/chat_event.dart';
import '../Bloc/chat_state.dart';


import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String reciver;
  final String chatId;

  const ChatPage({Key? key, required this.chatId , required this.reciver}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Map<String, dynamic>> messages = [];
  String currentUserId = "user1";

  void _sendMessage() {
    final text = _textController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        messages.add({
          "senderId": currentUserId,
          "message": text,
        });
      });
      _textController.clear();
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildCustomAppBar(),
      body: Column(
        children: [
          Expanded(
            child: messages.isEmpty
                ? const Center(
                    child: Text(
                      'No messages yet. Start the conversation!',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    reverse: true,
                    padding: const EdgeInsets.all(12),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[messages.length - 1 - index];
                      final isMe = message['senderId'] == currentUserId;
                      return _buildMessageBubble(message['message'], isMe: isMe);
                    },
                  ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildCustomAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      titleSpacing: 0,
      title: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.pinkAccent,
            child: Text("👋"), // Replace with user avatar or image
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Text( widget.reciver
               ,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              Text(
                "8 members, 5 online",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.call, color: Colors.black),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.videocam, color: Colors.black),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildMessageBubble(String text, {bool isMe = false}) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        decoration: BoxDecoration(
          color: isMe ? Colors.blueAccent : Colors.grey.shade200,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: Radius.circular(isMe ? 12 : 0),
            bottomRight: Radius.circular(isMe ? 0 : 12),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isMe ? Colors.white : Colors.black87,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.attach_file, color: Colors.black54),
              onPressed: () {},
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        decoration: const InputDecoration(
                          hintText: 'Write your message',
                          border: InputBorder.none,
                        ),
                        textCapitalization: TextCapitalization.sentences,
                        minLines: 1,
                        maxLines: 5,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send, size: 20, color: Colors.black54),
                      onPressed: () {
                        return _sendMessage();
                      },
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.camera_alt, color: Colors.black54),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.mic, color: Colors.black54),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}




// class ChatPage extends StatefulWidget {
//   final String chatId;

//   const ChatPage({Key? key, required this.chatId}) : super(key: key);

//   @override
//   State<ChatPage> createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   final TextEditingController _textController = TextEditingController();
//   final ScrollController _scrollController = ScrollController();

//   late ChatBloc _chatBloc;
//   String? currentUserId;

//   @override
//   void initState() {
//     super.initState();
//     _chatBloc = BlocProvider.of<ChatBloc>(context);

//     currentUserId = getCurrentUserIdFromToken();
//     _chatBloc.add(LoadChatMessages(widget.chatId));
//   }

//   @override
//   void dispose() {
//     _textController.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }

//   String getCurrentUserIdFromToken() {
//     // Replace with real logic: decode token or get from auth provider
//     return 'userIdFromTokenOrAuthState';
//   }

//   void _sendMessage() {
//     final text = _textController.text.trim();
//     if (text.isNotEmpty) {
//       _chatBloc.add(SendMessageEvent(widget.chatId, text, 'text'));
//       _textController.clear();
//       _scrollToBottom();
//     }
//   }

//   void _scrollToBottom() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (_scrollController.hasClients) {
//         _scrollController.animateTo(
//           0.0,
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeOut,
//         );
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Chat')),
//       body: Column(
//         children: [
//           Expanded(
//             child: BlocConsumer<ChatBloc, ChatState>(
//               listener: (context, state) {
//                 if (state is ChatLoaded) {
//                   _scrollToBottom();
//                 }
//               },
//               builder: (context, state) {
//                 if (state is ChatLoading) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (state is ChatLoaded) {
//                   final messages = state.messages;

//                   print(messages);

//                   if (messages.isEmpty) {
//                     return const Center(
//                       child: Text(
//                         'No messages yet. Start the conversation!',
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                     );
//                   }

//                   return ListView.builder(
//                     controller: _scrollController,
//                     reverse: true,
//                     padding: const EdgeInsets.all(12),
//                     itemCount: messages.length,
//                     itemBuilder: (context, index) {
//                       final message = messages[messages.length - 1 - index];
//                       // final isMe = message.senderId == currentUserId; // optional to style differently
//                       // return _buildMessageBubble(message.message);
//                     },
//                   );
//                 } else if (state is ChatError) {
//                   return Center(child: Text('Error: ${state.error}'));
//                 }

//                 return const SizedBox.shrink();
//               },
//             ),
//           ),
//           // Add some padding to avoid keyboard overlap
//           Padding(
//             padding: EdgeInsets.only(
//               bottom: MediaQuery.of(context).viewInsets.bottom,
//             ),
//             child: _buildInputArea(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMessageBubble(String text, {bool isMe = true}) {
//     return Align(
//       alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 4),
//         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
//         decoration: BoxDecoration(
//           color: isMe ? Colors.blueAccent : Colors.grey.shade200,
//           borderRadius: BorderRadius.only(
//             topLeft: const Radius.circular(12),
//             topRight: const Radius.circular(12),
//             bottomLeft: Radius.circular(isMe ? 12 : 0),
//             bottomRight: Radius.circular(isMe ? 0 : 12),
//           ),
//         ),
//         child: Text(
//           text,
//           style: TextStyle(
//             color: isMe ? Colors.white : Colors.black87,
//             fontSize: 15,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInputArea() {
//     return SafeArea(
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
//         color: Colors.white,
//         child: Row(
//           children: [
//             Expanded(
//               child: TextField(
//                 controller: _textController,
//                 decoration: const InputDecoration(
//                   hintText: 'Type your message...',
//                   border: InputBorder.none,
//                 ),
//                 textCapitalization: TextCapitalization.sentences,
//                 minLines: 1,
//                 maxLines: 5,
//               ),
//             ),
//             IconButton(
//               icon: const Icon(Icons.send),
//               color: Colors.blueAccent,
//               onPressed: _sendMessage,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

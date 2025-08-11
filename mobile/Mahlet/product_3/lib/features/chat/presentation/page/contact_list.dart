import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/chat_bloc.dart';
import '../Bloc/chat_event.dart';
import '../Bloc/chat_state.dart';
import 'chatpage.dart';

class ContactList extends StatefulWidget {
  const ContactList({super.key});

  @override
  State<ContactList> createState() => _ContactListState();
}


class _ContactListState extends State<ContactList> {


  late String selecteduser;
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_outlined),
        title: Text("Contact List"),
      ),
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state is Chatstartedstate) {
            debugPrint("🚀 Navigating to chat with ID: ${state.id}");
            // context.read<ChatBloc>().add(LoadChatMessages(state.id));
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ChatPage(chatId: state.id , reciver: selecteduser ,)),
            );
          } else if (state is ChatError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is ChatLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ChatError) {
            return Center(
              child: Text(
                state.error,
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (state is ContactLoad) {
            return ListView.builder(
              itemCount: state.contacts.length,
              itemBuilder: (context, index) {
                final contact = state.contacts[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blueAccent.shade200,
                    child: Text(contact.username[0]),
                    ),
                  title: Text(contact.username),
                  subtitle: Text(contact.email),
                  onTap: () {
                    debugPrint("✅ Joining chat: ${contact.id}");
                    context.read<ChatBloc>().add(StartChat(contact.id));
                    selecteduser = contact.username;
                  },
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

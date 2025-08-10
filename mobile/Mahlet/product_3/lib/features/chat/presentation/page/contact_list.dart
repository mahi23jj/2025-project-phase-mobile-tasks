import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/contect_model.dart';
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
  List<ContactModel> contacts = [
    ContactModel(id: "6898b39fba21526f150070a6", name: "Mr. Mahlet"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ChatLoading) {
            return CircularProgressIndicator();
          } else if (state is ChatError) {
            return Text(state.error, style: const TextStyle(color: Colors.red));
          } else if (state is ContactLoad) {
            return BlocConsumer<ChatBloc, ChatState>(
              listener: (context, state) {
                if (state is Chatstartedstate) {
                  context.read<ChatBloc>().add(LoadChatMessages(state.id));

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatPage(chatId: state.id),
                    ),
                  );
                } else if (state is ChatError) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.error)));
                }
              },
              builder: (context, state) {
               
                  return ListView.builder(
                    itemCount: contacts.length,
                    itemBuilder: (context, index) {
                      final contact = contacts[index];
                      return ListTile(
                        title: Text(contact.name),
                        onTap: () {
                          context.read<ChatBloc>().add(StartChat(contact.id));
                        },
                      );
                    },
                  );
                
                // return const SizedBox.shrink();
              },
            );

            // ListView.builder(
            //   itemCount: state.contacts.length,
            //   itemBuilder: (context, index) {
            //     return GestureDetector(
            //       onTap: () {
            //         context.read<ChatBloc>().add(
            //           StartChat(state.contacts[index].id),
            //         );

            //         Navigator.pushNamed(context, '/chat');
            //       },
            //       child: ListTile(
            //         title: Text(state.contacts[index].name),
            //         onTap: () {},
            //       ),
            //     );
            //   },
            // );
          }

          return Container();
        },
      ),
    );
  }
}

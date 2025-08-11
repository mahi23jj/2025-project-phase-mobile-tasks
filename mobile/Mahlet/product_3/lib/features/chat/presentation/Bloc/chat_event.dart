import 'package:equatable/equatable.dart';
import '../../domain/Entity/chat_message_Entity.dart';

abstract class ChatEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadChatMessages extends ChatEvent {
  final String chatId;

  LoadChatMessages(this.chatId);

  @override
  List<Object?> get props => [chatId];
}

class StartChat extends ChatEvent {
  final String contactId;

  StartChat(this.contactId);
}



class Loadcontact extends ChatEvent {}

class SendMessageEvent extends ChatEvent {
final String chatid;
   final String message;
    final String type;

  SendMessageEvent(this.chatid,this.message, this.type);

  @override
  List<Object?> get props => [message];
}

class MessageReceivedEvent extends ChatEvent {
  final ChatMessageEntity message;

  MessageReceivedEvent(this.message);

  @override
  List<Object?> get props => [message];
}

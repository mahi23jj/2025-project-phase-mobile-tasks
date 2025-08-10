import 'package:equatable/equatable.dart';
import '../../domain/Entity/chat_message_Entity.dart';
import '../../domain/Entity/chat_users.dart';

abstract class ChatState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ContactLoad extends ChatState {
  final List<ContactEntity> contacts;

  ContactLoad(this.contacts);
}

class ChatLoaded extends ChatState {
  final List<ChatMessageEntity> messages;

  ChatLoaded(this.messages);

  @override
  List<Object?> get props => [messages];
}

class ChatError extends ChatState {
  final String error;

  ChatError(this.error);

  @override
  List<Object?> get props => [error];
}

class Chatstartedstate extends ChatState{
  final String id;
  Chatstartedstate(this.id);

  
}

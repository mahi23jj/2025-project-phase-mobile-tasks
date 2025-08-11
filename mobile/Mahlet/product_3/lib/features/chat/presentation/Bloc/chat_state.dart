import 'package:equatable/equatable.dart';
import '../../../autentication/domain/Entity/user_entiry.dart';
import '../../domain/Entity/chat_message_Entity.dart';

abstract class ChatState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ContactLoad extends ChatState {
  final List<UserEntity> contacts;

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

class Chatstartedstate extends ChatState {
  final String id;
  final String reciverid;
  Chatstartedstate(this.id, this.reciverid);
}

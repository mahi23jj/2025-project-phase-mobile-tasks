import 'package:equatable/equatable.dart';

class ChatMessageEntity extends Equatable {
  final String chatid;
  final String senderId;
  final String message;

  ChatMessageEntity({
    required this.chatid,
    required this.senderId,
    required this.message,
      });

  @override
  List<Object> get props => [message, chatid, senderId];
}

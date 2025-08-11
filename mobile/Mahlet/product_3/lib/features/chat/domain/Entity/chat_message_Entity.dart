import 'package:equatable/equatable.dart';

import '../../../autentication/domain/Entity/user_entiry.dart';
import 'message_Entity.dart';

class ChatMessageEntity extends Equatable {
  final String chatid;
  final UserEntity sender;
  final MessageEntity message;
  final String content;
  final String type;

  const ChatMessageEntity({
    required this.chatid,
    required this.message,
    required this.type,
    required this.sender,
    required this.content,
  });

  @override
  List<Object> get props => [chatid, message, type, sender, content];
}

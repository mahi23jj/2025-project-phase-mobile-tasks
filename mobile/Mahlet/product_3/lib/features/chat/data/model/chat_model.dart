import '../../../autentication/data/model/user_model.dart';
import '../../../autentication/domain/Entity/user_entiry.dart';
import '../../domain/Entity/chat_message_Entity.dart';
import '../../domain/Entity/message_Entity.dart';
import 'message_model.dart';


import 'package:equatable/equatable.dart';
import '../../../autentication/domain/Entity/user_entiry.dart';
import '../../../autentication/data/model/user_model.dart';
import 'message_model.dart';


class ChatModel extends ChatMessageEntity {
   ChatModel({
    required String chatid,
    required UserModel sender,
    required MessageModel message,
    required String content,
    required String type,
  }) : super(
          chatid: chatid,
          content: content,
          message: message.toEntity(),
          sender: sender,
          type: type,
        );

  // from JSON
  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      chatid: json['chatId'] as String,
      content: json['content'] as String,
      message: MessageModel.fromJson(json['message']),
      sender: UserModel.fromJson(json['sender']),
      type: json['type'] as String,
    );
  }

  // to JSON
  Map<String, dynamic> toJson() {
    return {
      'chatId': chatid,
      'content': content,
      'message':  MessageModel.fromEntity(message).toJson(),
      'sender':  UserModel.fromEntity(sender).toJson(),
      'type': type,
    };
  }

  // to Entity (correct type)
  ChatMessageEntity toEntity() {
    return ChatMessageEntity(
      chatid: chatid,
      content: content,
      message: message,
      sender: sender,
      type: type,
    );
  }

  // from Entity
  factory ChatModel.fromEntity(ChatMessageEntity entity) {
    return ChatModel(
      chatid: entity.chatid,
      content: entity.content,
      message:MessageModel.fromEntity(entity.message) ,
      sender: UserModel.fromEntity(entity.sender),
      type: entity.type,
    );
  }
}




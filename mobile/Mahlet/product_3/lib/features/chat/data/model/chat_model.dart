import '../../domain/Entity/chat_message_Entity.dart';

class ChatModel extends ChatMessageEntity {
  ChatModel({
    required String chatid,
    required String senderId,
    required String message,
  }) : super(chatid: chatid, senderId: senderId, message: message);

  // form json
  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      chatid: json['_id'] as String,
      senderId: json['sender']?['_id'] as String? ?? '',
      message: json['type'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': chatid,
      'sender': {'_id': senderId},
      'type': message,
    };
  }

  // to entity
  factory ChatModel.toEntity(ChatMessageEntity chatMessageEntity) {
    return ChatModel(
      chatid: chatMessageEntity.chatid,
      senderId: chatMessageEntity.senderId,
      message: chatMessageEntity.message,
    );
  }
}

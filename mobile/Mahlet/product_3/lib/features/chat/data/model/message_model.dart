import '../../../autentication/data/model/user_model.dart';
import '../../../autentication/domain/Entity/user_entiry.dart';
import '../../domain/Entity/message_Entity.dart';

class MessageModel extends MessageEntity {
 MessageModel({
    required String id,
    required UserModel user1,
    required UserModel user2,
  }) : super(id: id, user1: user1, user2: user2);

  /// From JSON
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['_id'] ?? '',
      user1: UserModel.fromJson(json['user1']),
      user2: UserModel.fromJson(json['user2']),
    );
  }

  /// To JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user1': UserModel.fromEntity(user1).toJson(),
      'user2': UserModel.fromEntity(user2).toJson(),
    };
  }

  /// Convert Entity → Model
  factory MessageModel.fromEntity(MessageEntity entity) {
    return MessageModel(
      id: entity.id,
      user1: UserModel.fromEntity(entity.user1),
      user2: UserModel.fromEntity(entity.user2),
    );
  }

  /// Convert Model → Entity
  MessageEntity toEntity() {
    return MessageEntity(
      id: id,
      user1: user1,
      user2: user2,
    );
  }
}

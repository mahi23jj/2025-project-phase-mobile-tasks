import '../../domain/Entity/user_entiry.dart';

class UserModel extends UserEntity {
   UserModel({
    required String id,
    required String username,
    required String email,
  }) : super(id: id, username: username, email: email);

  /// From JSON (with "data" wrapper handling)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    print('📦 Raw JSON received in UserModel.fromJson: $json');

    // Some APIs return nested "data"
    final data = json['data'] ?? json; // fallback to root if no "data"
    if (data is! Map<String, dynamic>) {
      throw Exception('"data" field missing or invalid');
    }

    final id = data['id'] ?? data['_id'];
    final username = data['name'] ?? data['username'];
    final email = data['email'];

    print('🧩 Extracted values - id: $id, username: $username, email: $email');

    if (id == null) throw Exception('"id" is null');
    if (username == null) throw Exception('"name"/"username" is null');
    if (email == null) throw Exception('"email" is null');

    return UserModel(
      id: id,
      username: username,
      email: email,
    );
  }

  /// To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': username,
      'email': email,
    };
  }

  /// Convert Entity → Model
  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      username: entity.username,
      email: entity.email,
    );
  }

  /// Convert Model → Entity
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      username: username,
      email: email,
    );
  }
}

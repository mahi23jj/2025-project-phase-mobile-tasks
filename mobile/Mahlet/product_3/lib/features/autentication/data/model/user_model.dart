import '../../domain/Entity/user_entiry.dart';

class UserModel extends UserEntity {
  UserModel({
    required String id,
    required String username,
    required String email,
  }) : super(id: id, username: username, email: email);

  factory UserModel.fromJson(Map<String, dynamic> json) {
  print('📦 Raw JSON received in UserModel.fromJson: $json');

  // Step 1: Extract data object
  final data = json['data'];
  if (data == null || data is! Map<String, dynamic>) {
    throw Exception('"data" field missing or invalid');
  }

  // Step 2: Read values from inside "data"
  final id = data['id'];
  final username = data['name'];
  final email = data['email'];

  print('🧩 Extracted values - id: $id, username: $username, email: $email');

  if (id == null) throw Exception('"id" is null');
  if (username == null) throw Exception('"name" (username) is null');
  if (email == null) throw Exception('"email" is null');

  return UserModel(
    id: id,
    username: username,
    email: email,
  );
}


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': username,
      'email': email,
    
     
    };
  }

  factory UserModel.toentity(UserEntity userEntity) {
    return UserModel(
      id: userEntity.id,
      username: userEntity.username,
      email: userEntity.email,
    );
  }
}

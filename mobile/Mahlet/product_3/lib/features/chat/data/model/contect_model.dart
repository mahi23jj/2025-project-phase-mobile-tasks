import '../../domain/Entity/chat_users.dart';

class ContactModel extends ContactEntity {
  ContactModel({required String id, required String name})
    : super(id: id, name: name);

    // from json
  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['_id'], name: json['user1']['name']);
  }

  // to json  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

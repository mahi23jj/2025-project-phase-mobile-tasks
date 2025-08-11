import 'package:equatable/equatable.dart';

import '../../../autentication/domain/Entity/user_entiry.dart';

class MessageEntity extends Equatable {
  final String id;
  final UserEntity user1;
  final UserEntity user2;

  MessageEntity({
    required this.id,
    required this.user1,
    required this.user2,
      });

  @override
  List<Object> get props => [id, user1, user2];
}
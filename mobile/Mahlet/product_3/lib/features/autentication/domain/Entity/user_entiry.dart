import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String username;
  final String email;

  UserEntity({this.id = '', required this.username, required this.email});

  @override
  List<Object> get props => [username, email];
}

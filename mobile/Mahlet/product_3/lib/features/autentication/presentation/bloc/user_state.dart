import 'package:equatable/equatable.dart';

import '../../domain/Entity/user_entiry.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class RegisterUserstate extends UserState {
  UserEntity user;

  RegisterUserstate({required this.user});
}

class GetRememberMeState extends UserState {}

class SignOutState extends UserState {}

class GetUserIdState extends UserState {}

class LoginUserstate extends UserState {}

class UserError extends UserState {
  final String message;

  UserError(this.message);
}

import 'package:equatable/equatable.dart';

import '../../data/model/user_model.dart';
import '../../domain/Entity/user_entiry.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends UserEvent {
  final String email;
  final String password;

  LoginEvent(this.email, this.password);
}

class RegisterEvent extends UserEvent {
  final String name;
final  String email;
  final String password ; 

  RegisterEvent(this.name, this.email, this.password);
}

class LogoutEvent extends UserEvent {}

class GetRememberMeEvent extends UserEvent {}

class GetUserIdEvent extends UserEvent {}

class SignoutEvent extends UserEvent {}

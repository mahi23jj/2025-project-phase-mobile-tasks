import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class ServerFailure extends Failure {
    @override
  final List<Object?> props;
  final String? message;

  ServerFailure(this.message) : props = [message];


 
}

class CacheFailure extends Failure {
  @override
  List<Object?> get props => [];
}

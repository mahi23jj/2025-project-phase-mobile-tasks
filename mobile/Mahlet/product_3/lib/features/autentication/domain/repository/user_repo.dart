import 'package:dartz/dartz.dart';

import '../../../../core/Error/failure.dart';
import '../Entity/user_entiry.dart';

abstract class UserRepository {
  // autentication
  Future<Either<Failure, void>> signIn(String email, String password);
  Future<Either<Failure, UserEntity>> signUp(String name, String email ,String password);
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, String>> getCurrentUserId();
  Future<Either<Failure, String>> getrememberme();
}

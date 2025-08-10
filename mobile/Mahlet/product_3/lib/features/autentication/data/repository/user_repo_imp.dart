import 'package:dartz/dartz.dart';

import '../../../../core/Error/exception.dart';
import '../../../../core/Error/failure.dart';
import '../../../product/data/data_source/local_data_source_imp.dart';
import '../../domain/Entity/user_entiry.dart';
import '../../domain/repository/user_repo.dart';
import '../data_source/local_data_source.dart';
import '../data_source/remote_data_source.dart';
import '../model/user_model.dart';

class UserRepoImp extends UserRepository {
  final LocalUserDataSource localDataSource;
  final RemoteUserDataSource remoteDataSource;

  UserRepoImp({required this.localDataSource, required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> signIn(String email, String password) async {
    try {
      final userData = await remoteDataSource.signIn(email, password);

      final token = userData['data']['access_token'];
      if (token == null) {
        return Left(ServerFailure('Token missing in API response'));
      }

      await localDataSource.savetoken(token);
      print('Token saved: $token');

      // Optional: You can also save user info if needed
      // await localDataSource.saveUser(UserModel.fromJson(userData['user']));

      return Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    } on NetworkException catch (e) {
      return Left(ServerFailure(e.message));
    }catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUp(
    String name,
    String email,
    String password,
  ) async {
    try {
      final result = await remoteDataSource.signUp(name, email, password);
      return Right(UserModel.toentity(result));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    } on NetworkException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      final user = await remoteDataSource.signOut();
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getCurrentUserId() async {
    try {
      final user = await remoteDataSource.getCurrentUserId();
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getrememberme() async {
    try {
      final user = await localDataSource.getrememberme();
      return Right(user);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}

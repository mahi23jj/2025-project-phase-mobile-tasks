import 'package:dartz/dartz.dart';

import '../../../../core/Error/failure.dart';
import '../Entity/user_entiry.dart';
import '../repository/user_repo.dart';

 class Signup {
  final UserRepository userRepository;

  Signup(this.userRepository);

  Future<Either<Failure, UserEntity>> call(String name , String email, String password) async {
    // TODO: implement call
    return await userRepository.signUp(name, email, password);
  }
}

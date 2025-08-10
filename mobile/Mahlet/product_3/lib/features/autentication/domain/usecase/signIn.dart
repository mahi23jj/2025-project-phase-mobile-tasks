import 'package:dartz/dartz.dart';

import '../../../../core/Error/failure.dart';
import '../Entity/user_entiry.dart';
import '../repository/user_repo.dart';

 class Signin {
  final UserRepository userRepository;

  Signin(this.userRepository);

  Future<Either<Failure, void>> call(
    String email,
    String password,
  ) async {
    // TODO: implement call
    return await userRepository.signIn(email, password);
  }
}

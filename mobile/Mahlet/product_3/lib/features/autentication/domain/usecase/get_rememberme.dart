import 'package:dartz/dartz.dart';

import '../../../../core/Error/failure.dart';
import '../Entity/user_entiry.dart';
import '../repository/user_repo.dart';

 class Getrememberme {
  final UserRepository userRepository;

  Getrememberme(this.userRepository);

  Future<Either<Failure, String>> call() async {
    // TODO: implement call
    return await userRepository.getrememberme();
  }
}

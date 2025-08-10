import 'package:dartz/dartz.dart';

import '../../../../core/Error/failure.dart';
import '../Entity/user_entiry.dart';
import '../repository/user_repo.dart';

 class Signout {
  final UserRepository userRepository;

  Signout(this.userRepository);

  Future<Either<Failure, void>> call() async {
    // TODO: implement call
    return await userRepository.signOut();
  }
}

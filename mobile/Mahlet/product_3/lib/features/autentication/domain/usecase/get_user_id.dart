import 'package:dartz/dartz.dart';

import '../../../../core/Error/failure.dart';
import '../Entity/user_entiry.dart';
import '../repository/user_repo.dart';

 class GetUserId {
  final UserRepository userRepository;

  GetUserId(this.userRepository);

  Future<Either<Failure, String>> call() async {
    // TODO: implement call
    return await userRepository.getCurrentUserId();
  }
}

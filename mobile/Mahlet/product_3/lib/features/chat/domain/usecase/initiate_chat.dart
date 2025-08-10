import 'package:dartz/dartz.dart';

import '../../../../core/Error/failure.dart';
import '../repository/chat_repo.dart';

class InitiateChat {
  final ChatRepository _chatRepository;

  InitiateChat(this._chatRepository);

  Future<Either<Failure, String>> call(String userid) async {
    return _chatRepository.initiatechat(userid);
  }
}

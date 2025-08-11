import 'package:dartz/dartz.dart';

import '../../../../core/Error/failure.dart';
import '../Entity/chat_message_Entity.dart';
import '../repository/chat_repo.dart';

class SendMessage {
  final ChatRepository _chatRepository;

  SendMessage(this._chatRepository);

  Future<Either<Failure, void>> call( String chatid,
    String message,
    String type,) async {
    return _chatRepository.sendmessage(chatid, message, type);
  }


}

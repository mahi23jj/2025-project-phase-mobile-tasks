import 'package:dartz/dartz.dart';

import '../../../../core/Error/failure.dart';
import '../Entity/chat_message_Entity.dart';
import '../Entity/chat_users.dart';

abstract class ChatRepository {
  // autentication
  Future<Either<Failure,List<ContactEntity>>> getContacts();
  Future<Either<Failure, String>> initiatechat(String userid);
  Future<Either<Failure, void>> sendmessage(ChatMessageEntity message);
  Stream<ChatMessageEntity> subscribeToMessages(String chatId);
}

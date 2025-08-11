import 'package:dartz/dartz.dart';

import '../../../../core/Error/failure.dart';
import '../../../autentication/domain/Entity/user_entiry.dart';
import '../Entity/chat_message_Entity.dart';


abstract class ChatRepository {
  // autentication
  Future<Either<Failure, List<UserEntity>>> getContacts();
  // Future<Either<Failure, List<ContactEntity>>> getContacts();
  Future<Either<Failure, String>> initiatechat(String userid);
  Future<Either<Failure, void>> sendmessage(
    String chatid,
    String message,
    String type,
  );

  Stream<ChatMessageEntity> subscribeToMessages(String chatId);

  /// Fetch all messages inside a chat by its ID.
  // Future<Either<Failure, List<ChatMessageEntity>>> getChatMessages(String chatId);

  // /// Listen for new incoming messages
  // Stream<Either<Failure, ChatMessageEntity>> get messageReceivedStream;

  // /// Listen for delivery confirmation of sent messages
  // Stream<Either<Failure, ChatMessageEntity>> get messageDeliveredStream;




}
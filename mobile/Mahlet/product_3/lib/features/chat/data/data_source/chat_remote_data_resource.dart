import '../../../autentication/domain/Entity/user_entiry.dart';
import '../../domain/Entity/chat_message_Entity.dart';
import '../model/chat_model.dart';

abstract class ChatRemoteDataSource {
  Future<String> startChat(String userId);
  // Stream<ChatModel> getMessages(String chatId);
  Future<void> sendMessage(String chatid, String message, String type);

  Stream<ChatMessageEntity> subscribeToMessages(String chatId);

  Future<List<UserEntity>> getContacts();
}

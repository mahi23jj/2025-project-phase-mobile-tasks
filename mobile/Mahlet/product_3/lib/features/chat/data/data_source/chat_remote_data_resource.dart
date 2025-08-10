import '../../domain/Entity/chat_message_Entity.dart';
import '../../domain/Entity/chat_users.dart';
import '../model/chat_model.dart';

abstract class ChatRemoteDataSource {
  Future<String> startChat(String userId);
  // Stream<ChatModel> getMessages(String chatId);
  Future<void> sendMessage(ChatMessageEntity message);

  Stream<ChatMessageEntity> subscribeToMessages(String chatId);

  Future<List<ContactEntity>> getContacts();
}

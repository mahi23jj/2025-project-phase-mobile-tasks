import 'package:dartz/dartz.dart';

import '../../../../core/Error/failure.dart';
import '../Entity/chat_message_Entity.dart';
import '../repository/chat_repo.dart';

class SubscribeToMessage {
  final ChatRepository _chatRepository;

  SubscribeToMessage(this._chatRepository);

  Stream<ChatMessageEntity> call(String chatId) {
    return _chatRepository.subscribeToMessages(chatId);
  }
}

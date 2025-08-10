import 'package:dartz/dartz.dart';

import '../../../../core/Error/exception.dart';
import '../../../../core/Error/failure.dart';
import '../../domain/Entity/chat_message_Entity.dart';
import '../../domain/Entity/chat_users.dart';
import '../../domain/repository/chat_repo.dart';
import '../data_source/chat_remote_data_resource.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/Error/exception.dart';
import '../../../../core/Error/failure.dart';
import '../../domain/Entity/chat_message_Entity.dart';
import '../../domain/repository/chat_repo.dart';
import '../data_source/chat_remote_data_resource.dart';

class ChatRepoImp extends ChatRepository {
  final ChatRemoteDataSource chatRemoteDataSource;

  ChatRepoImp({required this.chatRemoteDataSource});

  @override
  Future<Either<Failure, String>> initiatechat(String userid) async {
    try {
      final response = await chatRemoteDataSource.startChat(userid);
      return Right(response);
    } on NetworkException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> sendmessage(ChatMessageEntity message) async {
    try {
      await chatRemoteDataSource.sendMessage(message); // Await here
      return const Right(null);
    } on NetworkException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Stream<ChatMessageEntity> subscribeToMessages(String chatId) {
    try {
      // This method will directly forward the stream from data source
      return chatRemoteDataSource.subscribeToMessages(chatId);
    } catch (e) {
      // Instead of throwing, you could also return an empty stream if needed
      return Stream.error(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ContactEntity>>> getContacts() async {
    try {
      final response = await chatRemoteDataSource.getContacts();
      return Right(response);
    } on NetworkException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}

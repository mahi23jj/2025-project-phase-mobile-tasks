import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/injection_container.dart';
import '../../../autentication/data/data_source/local_data_source.dart';
import '../../domain/Entity/chat_message_Entity.dart';
import '../../domain/Entity/chat_users.dart';
import '../Service/sockat_io.dart';
import '../model/chat_model.dart';
import '../model/contect_model.dart';
import 'chat_remote_data_resource.dart';

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final http.Client client;
  final LocalUserDataSource authLocalDataSource;
  // final WebSocketService socket;          // Make sure this matches your class name

  ChatRemoteDataSourceImpl({
    required this.client,
    required this.authLocalDataSource,
    // required this.socket,
  });


 final socket = sl<WebSocketService>();

  @override
  Future<String> startChat(String userId) async {
    // throw UnimplementedError();
    final token = await authLocalDataSource.gettoken();

    final response = await client.post(
      Uri.parse('https://g5-flutter-learning-path-be-tvum.onrender.com/api/v3/chats'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'userId': userId}),
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {

   
      final data = jsonDecode(response.body);
      final chatId = data['chatId'];



      // Join chat room after getting chatId (important for receiving messages)
      if (chatId != null) {
        socket.joinChat(chatId);
      }

      return chatId;
    } else {
      throw Exception('Failed to create/get chat');
    }
  }

  @override
  Future<void> sendMessage(ChatMessageEntity message) async {
    // throw UnimplementedError();
    // Convert entity to model (assuming ChatModel.toEntity converts the other way)
    final chatModel = ChatModel.toEntity(message);

    // // Send message through socket
    socket.sendMessage(chatModel);
  }

  @override
  Stream<ChatMessageEntity> subscribeToMessages(String chatId) {
    // throw UnimplementedError();
    socket.joinChat(chatId);
    return socket.messageStream
        .where((msg) => msg.chatid == chatId)
        .map((msg) => ChatModel.toEntity(msg));
  }

  @override
  Future<List<ContactEntity>> getContacts() async {
    final token = await authLocalDataSource.gettoken();

    final response = await http.get(
      Uri.parse(
        'https://g5-flutter-learning-path-be-tvum.onrender.com/api/v3/chats',
      ),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      // Adjust based on actual API structure
      final List<dynamic> dataList = decoded is List
          ? decoded
          : decoded['data'];

      return dataList
          .map((contactJson) => ContactModel.fromJson(contactJson))
          .toList();
    } else {
      throw Exception(
        'Failed to load contacts: ${response.statusCode} ${response.reasonPhrase} ${response.body}',
      );
    }
  }
}

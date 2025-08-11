import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/injection_container.dart';
import '../../../autentication/data/data_source/local_data_source.dart';
import '../../../autentication/data/model/user_model.dart';
import '../../../autentication/domain/Entity/user_entiry.dart';
import '../../domain/Entity/chat_message_Entity.dart';

import '../Service/sockat_io.dart';
import '../model/chat_model.dart';
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
      Uri.parse(
        'https://g5-flutter-learning-path-be-tvum.onrender.com/api/v3/chats',
      ),
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
      print(data);
      final chatId = data['data']['_id'];
      print("Chat ID: $chatId");

      // Join chat room after getting chatId (important for receiving messages)
      if (chatId != null) {
        // socket.joinChat(chatId);
      } else {
        throw Exception('Failed to get chatid');
      }

      return chatId;
    } else {
      throw Exception('Failed to create/get chat');
    }
  }



@override
Future<void> sendMessage(String chatId, String message, String type) async {
  try {
    final success = await socket.sendMessage(
      chatId: chatId,
      content: message,
      type: type,
    );

    if (!success) {
      throw Exception('Failed to send message to chatId=$chatId');
    }

    print('✅ Message sent successfully to chatId=$chatId');
  } catch (e) {
    print('❌ Error sending message: $e');
    rethrow; // Pass the error up so the Bloc/UseCase can handle it
  }
}


@override
Stream<ChatMessageEntity> subscribeToMessages(String chatId) {

  throw UnimplementedError();
  // Make sure we join the chat room so we actually receive its messages
  // socket.joinRoom(chatId);

  // print("📡 Subscribing to messages for chat ID: $chatId");

  // return socket.messageStream // This returns Stream<Map<String, dynamic>>
  //     .where((raw) {
  //       final rawChatId = raw['chatId']?.toString();
  //       final match = rawChatId == chatId;
  //       print('🔍 Filtering message with chatId=$rawChatId: match=$match');
  //       return match;
  //     })
  //     .map((raw) {
  //       // Convert raw map to ChatModel, then to Entity
  //       final chatModel = ChatModel.fromJson(raw);
  //       print('🗺 Mapping ChatModel to Entity: ${chatModel.message}');
  //       return chatModel.toEntity();
  //     });
}



  // @override
  // Stream<ChatMessageEntity> subscribeToMessages(String chatId) {
  //   // socket.joinChat(chatId);
  //   print("Subscribing to messages for chat ID: $chatId");

  //   print("Raw socket.messageStream: $socket.messageStream");

  //   return socket.messageStream
  //       .where((msg) {
  //         final match = msg.chatid == chatId;
  //         print('Filtering message with chatid=${msg.chatid}: match=$match');
  //         return match;
  //       })
  //       .map((msg) {
  //         print('Mapping ChatModel to Entity for message: ${msg.message}');
  //         return msg.toEntity();
  //       });
  // }

  @override
  Future<List<UserEntity>> getContacts() async {
    final token = await authLocalDataSource.gettoken();

    final response = await http.get(
      Uri.parse(
        'https://g5-flutter-learning-path-be-tvum.onrender.com/api/v3/users',
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
          .map((contactJson) => UserModel.fromJson(contactJson))
          .toList();
    } else {
      throw Exception(
        'Failed to load contacts: ${response.statusCode} ${response.reasonPhrase} ${response.body}',
      );
    }
  }
}

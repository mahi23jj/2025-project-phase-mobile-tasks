import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/injection_container.dart';
import '../../data/Service/sockat_io.dart';
import '../../data/model/chat_model.dart';
import '../../domain/Entity/chat_message_Entity.dart';
import '../../domain/Entity/chat_users.dart';
import '../../domain/repository/chat_repo.dart';
import '../../domain/usecase/get_contact.dart';
import '../../domain/usecase/initiate_chat.dart';
import '../../domain/usecase/send_message.dart';
import '../../domain/usecase/subscribe_to_message.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetContactsUseCase getContactsUseCase;
  final InitiateChat initiateChat;
  final SendMessage sendMessage;
  final SubscribeToMessage subscribeToMessage;
  final WebSocketService webSocketService;

  late StreamSubscription<ChatMessageEntity> _messagesSubscription;

  ChatBloc({
    required this.getContactsUseCase,
    required this.initiateChat,
    required this.sendMessage,
    required this.subscribeToMessage,
    required this.webSocketService,
  }) : super(ChatInitial()) {
    _init();
     on<StartChat>(_onstartchat);
    on<Loadcontact>(_onLoadContact);
    on<LoadChatMessages>(_onLoadChatMessages);
    on<SendMessageEvent>(_onSendMessage);
    on<MessageReceivedEvent>(_onMessageReceived);
  }

  Future<void> _init() async {
    print('WebSocketService connecting...');
    try {
      await webSocketService.connect();
      print('WebSocketService connected successfully');

      // Subscribe to incoming messages
      _messagesSubscription = webSocketService.messageStream.listen((
        chatModel,
      ) {
        print('New message received: ${chatModel.message}');
        add(MessageReceivedEvent(ChatModel.toEntity(chatModel)));
        // assuming ChatModel has toEntity()
      });
    } catch (e) {
      print('Error connecting WebSocketService: $e');
    }
  }

  Future<void> _onstartchat(
    StartChat event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());
    final result = await initiateChat.call(event.contactId);
    result.fold(
      (failure) => emit(ChatError(failure.toString())),
      (id) => emit(Chatstartedstate(id)),
    );
  }


  Future<void> _onLoadContact(
    Loadcontact event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());
    final result = await getContactsUseCase();
    result.fold(
      (failure) => emit(ChatError(failure.toString())),
      (contacts) => emit(ContactLoad(contacts)),
    );
  }

  Future<void> _onLoadChatMessages(
    LoadChatMessages event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());
    try {
      // Cancel old subscription if needed
      // await _messagesSubscription?.cancel();

      _messagesSubscription = subscribeToMessage(event.chatId).listen(
        (message) {
          add(MessageReceivedEvent(message));
        },
        onError: (error) {
          // Optional: handle errors from the stream
          print('Error receiving message: $error');
        },
      );

      // Listen for messages from this chat
      emit(ChatLoaded([])); // Start with empty
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> _onSendMessage(
    SendMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    if (state is ChatLoaded) {
      try {
        await sendMessage(event.message);
      } catch (e) {
        emit(ChatError(e.toString()));
      }
    }
  }

  void _onMessageReceived(MessageReceivedEvent event, Emitter<ChatState> emit) {
    if (state is ChatLoaded) {
      final updated = List<ChatMessageEntity>.from(
        (state as ChatLoaded).messages,
      )..add(event.message);
      emit(ChatLoaded(updated));
    }
  }

  @override
  Future<void> close() {
    print('ChatBloc closing, cancelling subscriptions');
    _messagesSubscription?.cancel();
    webSocketService.disconnect();
    return super.close();
  }
}

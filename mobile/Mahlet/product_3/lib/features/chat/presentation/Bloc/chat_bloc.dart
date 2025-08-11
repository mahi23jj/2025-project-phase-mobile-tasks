import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/injection_container.dart';
import '../../data/Service/sockat_io.dart';
import '../../data/model/chat_model.dart';
import '../../domain/Entity/chat_message_Entity.dart';

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

  StreamSubscription<ChatMessageEntity>? _messagesSubscription;

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
    // webSocketService.

    // webSocketService.onMessageReceived = (msg) {
    //   print('🔔 Message received via WebSocketService: ${msg.message}');
    //   add(MessageReceivedEvent(msg.toEntity()));
    // };

    await webSocketService.connect();
    print('sockte connecting');
  }

  Future<void> _onstartchat(StartChat event, Emitter<ChatState> emit) async {
    print("📨 StartChat event received with contactId: ${event.contactId}");
    emit(ChatLoading());
    print("🚀 Emitted state: ChatLoading");

    final result = await initiateChat.call(event.contactId);
    print("✅ initiateChat call finished. Result: $result");

    result.fold(
      (failure) {
        print("❌ Failure detected: $failure");
        emit(ChatError(failure.toString()));
        print("🚀 Emitted state: ChatError");
      },
      (id) {
        print("💬 Chat started with ID: $id");
        emit(Chatstartedstate(id, event.contactId));
        print("🚀 Emitted state: Chatstartedstate");
      },
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
      // await _messagesSubscription?.cancel();

      _messagesSubscription = subscribeToMessage(event.chatId).listen(
        (message) {
          print('🔔 Incoming message from stream: ${message.message}');
          add(MessageReceivedEvent(message));
        },
        onError: (error) {
          print('Error receiving message: $error');
          emit(ChatError(error.toString()));
        },
      );

      // Start with empty message list; messages will come from stream
      emit(ChatLoaded([]));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> _onSendMessage(
    SendMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    print('📨 SendMessageEvent received with message: ${event.message}');
    if (state is ChatLoaded) {
      print('🟢 Current state is ChatLoaded, proceeding to send message');
      try {
        await sendMessage(event.chatid, event.message, event.type);
        print('✅ Message sent successfully');
        // Do NOT emit state here — UI updates on message received from stream
      } catch (e, stackTrace) {
        print('❌ Error sending message: $e');
        print(stackTrace.toString());
        emit(ChatError(e.toString()));
      }
    } else {
      print('⚠️ Cannot send message because current state is not ChatLoaded');
    }
  }

  void _onMessageReceived(MessageReceivedEvent event, Emitter<ChatState> emit) {
    if (state is ChatLoaded) {
      final updated = List<ChatMessageEntity>.from(
        (state as ChatLoaded).messages,
      )..add(event.message);

      print(
        '🚀 Emitting ChatLoaded with updated messages count: ${updated.length}',
      );
      emit(ChatLoaded(updated));
    }
  }

  @override
  Future<void> close() {
    print('ChatBloc closing, cancelling subscriptions');
    _messagesSubscription?.cancel();
    // webSocketService.disconnect();
    return super.close();
  }
}

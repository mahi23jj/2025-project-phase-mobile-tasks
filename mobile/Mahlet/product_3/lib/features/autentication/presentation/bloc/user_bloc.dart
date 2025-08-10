import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecase/get_rememberme.dart';
import '../../domain/usecase/get_user_id.dart';
import '../../domain/usecase/signIn.dart';
import '../../domain/usecase/signout.dart';
import '../../domain/usecase/signup.dart';
import '../../presentation/bloc/user_event.dart';
import '../../presentation/bloc/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  late Getrememberme getrememberme;
  late GetUserId getUserId;
  late Signin signin;
  late Signout signout;
  late Signup signup;

  UserBloc({
    required this.getrememberme,
    required this.getUserId,
    required this.signin,
    required this.signout,
    required this.signup,
  }) : super(UserInitial()) {



    on<RegisterEvent>((event, emit) async {
  print('🔁 RegisterEvent received');

  if (state is UserInitial) {
    print('🟡 Current state: UserInitial');
    emit(UserLoading());
    print('⏳ Emitted UserLoading');

    try {
      print('📤 Calling signup use case...');
      final result = await signup.call(event.name,event.email,event.password);
      print('✅ Got response from signup');

      result.fold(
        (failure) {
          print('❌ Signup failed with: ${failure.toString()}');
          emit(UserError(failure.toString()));
        },
        (value) {
          print('✅ Signup successful');
          emit(RegisterUserstate(
            user: value
          ));
        },
      );
    } catch (e, stacktrace) {
      print('🔥 Unexpected error during signup: $e');
      print('📄 Stacktrace: $stacktrace');
      emit(UserError('Unexpected error: $e'));
    }
  } else {
    print('⚠️ State is not UserInitial, current state: $state');
  }
});

    // on<LoginEvent>((event, emit) async {
    //   if (state is UserInitial) {
    //     emit(UserLoading());
    //     final result = await signin.call(event.email, event.password);

    //     result.fold((l) => emit(UserError(l.toString())), (r) => emit(LoginUserstate()));
    //   }
    // });

on<LoginEvent>((event, emit) async {
  print('🟢 LoginEvent received with email: ${event.email}');

  if (state is UserInitial) {
    print('📌 Current state is UserInitial, proceeding with login...');
    emit(UserLoading());
    print('⏳ Emitted UserLoading state');

    try {
      final result = await signin.call(event.email, event.password);
      print('📦 Result from signin use case: $result');

      result.fold(
        (failure) {
          print('🚨 Login failed: $failure');
          emit(UserError(failure.toString()));
        },
        (_) {
          print('✅ Login successful, emitting LoginUserstate');
          emit(LoginUserstate());
        },
      );
    } catch (e, stack) {
      print('🔥 Unexpected error during login: $e');
      print('📄 Stacktrace: $stack');
      emit(UserError('Unexpected error: $e'));
    }
  } else {
    print('⚠️ LoginEvent ignored because current state is not UserInitial. State: $state');
  }
});




    on<GetRememberMeEvent>((event, emit) async {
      if (state is UserInitial) {
        emit(UserLoading());
        final result = await getrememberme.call();

        result.fold(
          (l) => emit(UserError(l.toString())),
          (r) => emit(LoginUserstate()),
        );
      }
    });

    on<GetUserIdEvent>((event, emit) async {
      if (state is UserInitial) {
        emit(UserLoading());
        final result = await getUserId.call();

        result.fold((l) => emit(UserError(l.toString())), (r) => emit(GetUserIdState()));
      }
    });

    on<SignoutEvent>((event, emit) async {
      if (state is UserInitial) {
        emit(UserLoading());
        final result = await signout.call();

        result.fold((l) => emit(UserError(l.toString())), (r) => emit(SignOutState()));
      }
    });
  }
}

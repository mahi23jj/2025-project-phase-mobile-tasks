import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/autentication/data/data_source/local_data_source.dart';
import '../features/autentication/data/data_source/local_data_source_imp.dart';
import '../features/autentication/data/data_source/remote_data_source.dart';
import '../features/autentication/data/data_source/remote_data_source_imp.dart';
import '../features/autentication/data/repository/user_repo_imp.dart';
import '../features/autentication/domain/repository/user_repo.dart';
import '../features/autentication/domain/usecase/get_rememberme.dart';
import '../features/autentication/domain/usecase/get_user_id.dart';
import '../features/autentication/domain/usecase/signIn.dart';
import '../features/autentication/domain/usecase/signout.dart';
import '../features/autentication/domain/usecase/signup.dart';
import '../features/autentication/presentation/bloc/user_bloc.dart';

import '../features/chat/data/Service/sockat_io.dart';
import '../features/chat/data/data_source/chat_remote_data_resource.dart';
import '../features/chat/data/data_source/chat_remote_data_source_imp.dart';
import '../features/chat/data/repository/chat_repo_imp.dart';
import '../features/chat/domain/repository/chat_repo.dart';
import '../features/chat/domain/usecase/get_contact.dart';
import '../features/chat/domain/usecase/initiate_chat.dart';
import '../features/chat/domain/usecase/send_message.dart';
import '../features/chat/domain/usecase/subscribe_to_message.dart';
import '../features/chat/presentation/Bloc/chat_bloc.dart';

import 'platform/network_info.dart';
import 'service/image_picker_service.dart';

import '../features/product/data/data_source/local_data_source.dart';
import '../features/product/data/data_source/local_data_source_imp.dart';
import '../features/product/data/data_source/remote_data_source.dart';
import '../features/product/data/data_source/remote_data_source_imp.dart';
import '../features/product/data/repository/product_repository_imp.dart';
import '../features/product/data/service/image_picker_service_imp.dart';
import '../features/product/domain/Repository/product_repository.dart';
import '../features/product/domain/usecase/create_product.dart';
import '../features/product/domain/usecase/delete_Product.dart';
import '../features/product/domain/usecase/update_product.dart';
import '../features/product/domain/usecase/view_all_product.dart';
import '../features/product/domain/usecase/view_single_product.dart';
import '../features/product/presentation/bloc/product_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  sl.registerLazySingleton<http.Client>(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
  sl.registerLazySingleton<ImagePickerService>(() => ImagePickerServiceImpl());

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // Product Data sources
  sl.registerLazySingleton<ProductLocalDataSource>(
    () => LocalDataSourceImp(sl()),
  );
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => RemoteDataSourceImp(client: sl()),
  );

  // User Data sources
  sl.registerLazySingleton<LocalUserDataSource>(
    () => LocaluserDataSourceImp(sl()),
  );
  sl.registerLazySingleton<RemoteUserDataSource>(
    () => RemoteUserDataSourceImp(client: sl()),
  );

  // WebSocket Service (depends on LocalUserDataSource)
  sl.registerLazySingleton<WebSocketService>(
    () => WebSocketService(authService: sl()),
  );

  // Chat Data source
  sl.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSourceImpl(
      client: sl(),
      authLocalDataSource: sl<LocalUserDataSource>(),
    ),
  );

  // Repositories
  // sl.registerLazySingleton<ProductRepository>(
  //   () => ProductRepositoryImp(
  //     localDataSource: sl(),
  //     remoteDataSource: sl(),
  //   ),
  // );
  sl.registerLazySingleton<UserRepository>(
    () => UserRepoImp(
      localDataSource: sl(),
      remoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepoImp(chatRemoteDataSource: sl()),
  );

  // Product Use Cases
  sl.registerLazySingleton(() => CreateProduct(sl()));
  sl.registerLazySingleton(() => ViewAllProduct(sl()));
  sl.registerLazySingleton(() => ViewSingleProduct(sl()));
  sl.registerLazySingleton(() => DeleteProduct(sl()));
  sl.registerLazySingleton(() => UpdateProduct(sl()));

  // User Use Cases
  sl.registerLazySingleton(() => Getrememberme(sl()));
  sl.registerLazySingleton(() => GetUserId(sl()));
  sl.registerLazySingleton(() => Signin(sl()));
  sl.registerLazySingleton(() => Signout(sl()));
  sl.registerLazySingleton(() => Signup(sl()));

  // Chat Use Cases
  sl.registerLazySingleton(() => GetContactsUseCase(sl()));
  sl.registerLazySingleton(() => InitiateChat(sl()));
  sl.registerLazySingleton(() => SendMessage(sl()));
  sl.registerLazySingleton(() => SubscribeToMessage(sl()));

  // Blocs
  sl.registerFactory(
    () => ProductBloc(
      createProduct: sl(),
      viewAllProduct: sl(),
      viewSingleProduct: sl(),
      updateProduct: sl(),
      deleteProduct: sl(),
    ),
  );

  sl.registerFactory(
    () => UserBloc(
      getUserId: sl(),
      getrememberme: sl(),
      signin: sl(),
      signout: sl(),
      signup: sl(),
    ),
  );

  sl.registerFactory(
    () => ChatBloc(
      getContactsUseCase: sl(),
      initiateChat: sl(),
      sendMessage: sl(),
      subscribeToMessage: sl(),
      webSocketService: sl(),
    ),
  );
}

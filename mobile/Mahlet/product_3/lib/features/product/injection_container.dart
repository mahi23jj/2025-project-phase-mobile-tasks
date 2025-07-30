import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as Http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/platform/network_info.dart';
import 'data/data_source/local_data_source.dart';
import 'data/data_source/local_data_source_imp.dart';
import 'data/data_source/remote_data_source.dart';
import 'data/data_source/remote_data_source_imp.dart';
import 'data/repository/product_repository_imp.dart';
import 'domain/Repository/product_repository.dart';
import 'domain/usecase/create_product.dart';
import 'domain/usecase/delete_Product.dart';
import 'domain/usecase/update_product.dart';
import 'domain/usecase/view_all_product.dart';
import 'domain/usecase/view_single_product.dart';
import 'presentation/bloc/product_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //  External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Http.Client);
  sl.registerLazySingleton(() => InternetConnectionChecker);

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //Data sources
  sl.registerLazySingleton<ProductLocalDataSource>(
    () => LocalDataSourceImp(sl()),
  );
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => RemoteDataSourceImp(client: sl()),
  );

  // Repository
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImp(
      productLocalDataSource: sl(),
      productRemoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => CreateProduct(sl()));
  sl.registerLazySingleton(() => ViewAllProduct(sl()));
  sl.registerLazySingleton(() => ViewSingleProduct(sl()));
  sl.registerLazySingleton(() => DeleteProduct(sl()));
  sl.registerLazySingleton(() => UpdateProduct(sl()));

  // Bloc
  sl.registerFactory(
    () => ProductBloc(
      createProduct: sl(),
      viewAllProduct: sl(),
      viewSingleProduct: sl(),
      updateProduct: sl(),
      deleteProduct: sl(),
    ),
  );
}

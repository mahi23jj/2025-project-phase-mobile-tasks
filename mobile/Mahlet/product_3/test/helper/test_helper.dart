import 'dart:io';

import 'package:http/http.dart';
import 'package:http/http.dart' as Http;
import 'package:mockito/annotations.dart';
import 'package:product_3/core/platform/network_info.dart';
import 'package:product_3/features/product/data/data_source/local_data_source.dart';
import 'package:product_3/features/product/data/data_source/remote_data_source.dart';
import 'package:product_3/features/product/domain/Repository/product_repository.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'test_helper.mocks.dart';

@GenerateMocks(
  [
    ProductRepository,
    ProductLocalDataSource,
    ProductRemoteDataSource,
    NetworkInfo,
    InternetConnectionChecker,
    SharedPreferences,
    Http.Client,
  ],
  // customeMock using http
  customMocks: [MockSpec<Http.Client>(as: #MockHttpClient)],
)
void main() {}

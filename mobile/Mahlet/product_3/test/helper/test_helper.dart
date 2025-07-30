import 'dart:io';

import 'package:http/http.dart';
import 'package:http/http.dart' as Http;
import 'package:mockito/annotations.dart';
import 'package:product_3/core/platform/network_info.dart';
import 'package:product_3/features/product/data/data_source/local_data_source.dart';
import 'package:product_3/features/product/data/data_source/remote_data_source.dart';
import 'package:product_3/features/product/domain/Repository/product_repository.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:product_3/features/product/domain/usecase/create_product.dart';
import 'package:product_3/features/product/domain/usecase/delete_Product.dart';
import 'package:product_3/features/product/domain/usecase/update_product.dart';
import 'package:product_3/features/product/domain/usecase/view_all_product.dart';
import 'package:product_3/features/product/domain/usecase/view_single_product.dart';
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
    CreateProduct,
    DeleteProduct,
    UpdateProduct,
    ViewAllProduct,
    ViewSingleProduct,
  ],
  // customeMock using http
  customMocks: [MockSpec<Http.Client>(as: #MockHttpClient)],
)
void main() {}

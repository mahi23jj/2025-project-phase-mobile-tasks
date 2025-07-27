import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:product_3/core/platform/network_info.dart';
import 'package:product_3/features/product/data/data_source/local_data_source.dart';
import 'package:product_3/features/product/data/data_source/remote_data_source.dart';
import 'package:product_3/features/product/domain/Repository/product_repository.dart';

@GenerateMocks(
  [
    ProductRepository,
    ProductLocalDataSource,
    ProductRemoteDataSource,
    NetworkInfo,
  ],
  // customeMock using http
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}

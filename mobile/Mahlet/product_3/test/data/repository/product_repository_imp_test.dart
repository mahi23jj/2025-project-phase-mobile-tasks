import 'package:flutter_test/flutter_test.dart';
import 'package:product_3/core/platform/network_info.dart';
import 'package:product_3/features/product/data/data_source/local_data_source.dart';
import 'package:product_3/features/product/data/data_source/remote_data_source.dart';
import 'package:product_3/features/product/data/repository/product_repository_imp.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late ProductRemoteDataSource productRemoteDataSource;
  late ProductLocalDataSource productLocalDataSource;
  late NetworkInfo networkInfo;
  late ProductRepositoryImp productRepositoryImp;

  setUp(() {
    productLocalDataSource = MockProductLocalDataSource();
    networkInfo = MockNetworkInfo();
    productRemoteDataSource = MockProductRemoteDataSource();
    productRepositoryImp = ProductRepositoryImp(
      networkInfo: networkInfo,
      productRemoteDataSource: productRemoteDataSource,
      productLocalDataSource: productLocalDataSource,
    );
  });

  
}

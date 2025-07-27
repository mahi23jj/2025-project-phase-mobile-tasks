
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/mockito.dart';
import 'package:product_3/core/platform/network_info.dart';

import '../../helper/test_helper.mocks.dart';




void main() {
 late NetworkInfoImpl networkInfo;
  late InternetConnectionChecker connectionChecker;


  setUp(() {
    connectionChecker = MockInternetConnectionChecker();
    networkInfo = NetworkInfoImpl(connectionChecker);
  });

  group('isConnected', () {
    test(
      'should forward the call to DataConnectionChecker.hasConnection',
      () async {
        // arrange

        when(connectionChecker.hasConnection)
            .thenAnswer((_) => Future.value(true));
        // act
        final result = await networkInfo.isConnected;
        // assert
        verify(connectionChecker.hasConnection);

        expect(result, true);
      },
    );
  });
}

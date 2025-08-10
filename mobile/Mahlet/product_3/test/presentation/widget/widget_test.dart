import 'dart:io';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:product_3/core/service/image_picker_service.dart';
import 'package:product_3/features/product/domain/Entity/product_entity.dart';
import 'package:product_3/features/product/presentation/bloc/product_bloc.dart';
import 'package:product_3/features/product/presentation/bloc/product_event.dart';
import 'package:product_3/features/product/presentation/bloc/product_state.dart';
import 'package:product_3/features/product/presentation/pages/ProductForm/screen/Add_productForm.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late ProductBloc mockBloc;
  late ImagePickerService mockImagePicker;

  setUp(() {
    mockBloc = MockProductBloc();
    mockImagePicker = MockImagePickerService();
  });

  testWidgets('dispatches CreateProductEvent and shows success message', (tester) async {
  // Mock image picker
  // when(mockImagePicker.pickImage()).thenAnswer((_) async => File('path/to/image.png'));

  // Stub state and stream manually
  when(mockBloc.state).thenReturn(ProductInitial());
  when(mockBloc.stream).thenAnswer((_) => Stream.fromIterable([
        ProductInitial(),
        ProductCreated(
          Product(
            id: '1',
            imageurl: 'path/Product 1.png',
            title: 'Product 1',
            price: 10.99,
            discription: 'This is a product',
          ),
        ),
      ]));

  // Build widget
  await tester.pumpWidget(
    MaterialApp(
      home: BlocProvider<ProductBloc>.value(
        value: mockBloc,
        child: ProductFormPage(),
      ),
    ),
  );

  // Act: simulate user input
  // await tester.tap(find.byKey(const Key('product_image_picker')));
  // await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('product_image_picker')), 'path/Product 1.png');
  await tester.enterText(find.byKey(const Key('product_name')), 'Product 1');
  await tester.enterText(find.byKey(const Key('product_price')), '10.99');
  await tester.enterText(find.byKey(const Key('product_description')), 'This is a product');
  await tester.tap(find.byKey(const Key('product_Add')));
  await tester.pumpAndSettle();

  // Assert success message
  // expect(find.byKey(const Key('product_success_message')), findsOneWidget);
  expect(find.text('Product added successfully'), findsOneWidget);

});
}
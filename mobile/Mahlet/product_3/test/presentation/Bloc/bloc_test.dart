import 'dart:ffi';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:product_3/core/Error/failure.dart';
import 'package:product_3/features/product/domain/Entity/product_entity.dart';
import 'package:product_3/features/product/domain/usecase/create_product.dart';
import 'package:product_3/features/product/domain/usecase/delete_Product.dart';
import 'package:product_3/features/product/domain/usecase/update_product.dart';
import 'package:product_3/features/product/domain/usecase/view_all_product.dart';
import 'package:product_3/features/product/domain/usecase/view_single_product.dart';
import 'package:product_3/features/product/presentation/bloc/product_bloc.dart';
import 'package:product_3/features/product/presentation/bloc/product_event.dart';
import 'package:product_3/features/product/presentation/bloc/product_state.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late MockCreateProduct createProduct;
  late MockDeleteProduct deleteProduct;
  late MockUpdateProduct updateProduct;
  late MockViewAllProduct viewAllProduct;
  late MockViewSingleProduct viewSingleProduct;
  late ProductBloc productBloc;

  final item = Product(
    id: 1,
    imageurl: 'https://example.com/image.png',
    title: 'Test Product',
    subtitle: 'Test Subtitle',
    price: 100,
    discription: 'This is a test product',
  );

    final newitem = Product(
    id: 2,
    imageurl: 'https://example.com/image.png',
    title: 'Test Product',
    subtitle: 'Test Subtitle',
    price: 200,
    discription: 'test product',
  );

  final items = [
    Product(
      id: 1,
      imageurl: 'https://example.com/image.png',
      title: 'Test Product',
      subtitle: 'Test Subtitle',
      price: 100,
      discription: 'This is a test product',
    ),
  ];

  int tid = 1;

  setUp(() {
    createProduct = MockCreateProduct();
    deleteProduct = MockDeleteProduct();
    updateProduct = MockUpdateProduct();
    viewAllProduct = MockViewAllProduct();
    viewSingleProduct = MockViewSingleProduct();

    productBloc = ProductBloc(
      createProduct: createProduct,
      deleteProduct: deleteProduct,
      updateProduct: updateProduct,
      viewAllProduct: viewAllProduct,
      viewSingleProduct: viewSingleProduct,
    );
  });

  blocTest<ProductBloc, ProductState>(
    'emits [ProductLoading, ProductCreated] when CreateProductEvent is added',
    build: () {
      when(createProduct.call(any)).thenAnswer((_) async => Right(item));
      return productBloc;
    },
    act: (bloc) => bloc.add(CreateProductEvent(item)),
    expect: () => [ProductLoading(), ProductCreated(item)],
  );

  blocTest<ProductBloc, ProductState>(
    'emits [ProductError] when CreateProductEvent is added',
    build: () {
      when(
        createProduct.call(any),
      ).thenAnswer((_) async => Left(ServerFailure()));
      return productBloc;
    },
    act: (bloc) => bloc.add(CreateProductEvent(item)),
    expect: () => [ProductLoading(), ProductError()],
  );

  blocTest<ProductBloc, ProductState>(
    'emits [ProductLoading, ProductLoaded] when LoadAllProductsEvent is added',
    build: () {
      when(viewAllProduct.call()).thenAnswer((_) async => Right(items));
      return productBloc;
    },
    act: (bloc) => bloc.add(LoadAllProductsEvent()),
    expect: () => [ProductLoading(), ProductLoaded(items)],
  );

  blocTest<ProductBloc, ProductState>(
    'emits [ProductError] when LoadAllProductsEvent is added',
    build: () {
      when(
        viewAllProduct.call(),
      ).thenAnswer((_) async => Left(ServerFailure()));
      return productBloc;
    },
    act: (bloc) => bloc.add(LoadAllProductsEvent()),
    expect: () => [ProductLoading(), ProductError()],
  );

  blocTest<ProductBloc, ProductState>(
    'emits [ProductLoading,ProductDeleted] when deleteProduct is added',
    build: () {
      when(deleteProduct.call(tid)).thenAnswer((_) async => const Right(null));
      return productBloc;
    },
    act: (bloc) => bloc.add(DeleteProductEvent(tid)),
    expect: () => [ProductLoading(), ProductDeleted()],
  );

  blocTest<ProductBloc, ProductState>(
    'emits [ProductError] when deleteProduct is added',
    build: () {
      when(deleteProduct.call(tid)).thenAnswer((_) async => Left(ServerFailure()));
      return productBloc;
    },
    act: (bloc) => bloc.add(DeleteProductEvent(tid)),
    expect: () => [ProductLoading(), ProductError()],
  );

blocTest<ProductBloc, ProductState>(
  'emits [ProductLoading, ProductUpdated] when UpdateProductEvent succeeds',
  build: () {
    when(updateProduct.call(tid, item)).thenAnswer((_) async => Right(newitem));
      return productBloc;
  },
  act: (bloc) => bloc.add(UpdateProductEvent(tid, item)),
  expect: () => [ProductLoading(), ProductUpdated(newitem)],
);

blocTest<ProductBloc, ProductState>(
  'emits [ProductLoading, ProductError] when UpdateProductEvent fails',
  build: () {
    when(updateProduct.call(tid, item)).thenAnswer((_) async => Left(ServerFailure()));
      return productBloc;
  },
  act: (bloc) => bloc.add(UpdateProductEvent(tid, item)),
  expect: () => [ProductLoading(), ProductError()],
);

blocTest<ProductBloc, ProductState>(
  'emits [ProductLoading, SingleProduct] when GetSingleProductEvent succeeds',
  build: () {
    when(viewSingleProduct.call(tid)).thenAnswer((_) async => Right(newitem));
    return productBloc;
  },
  act: (bloc) => bloc.add(GetSingleProductEvent(tid)),
  expect: () => [ProductLoading(), SingleProduct(item)],
);

blocTest<ProductBloc, ProductState>(
  'emits [ProductLoading, ProductError] when GetSingleProductEvent fails',
  build: () {
     when(viewSingleProduct.call(tid)).thenAnswer((_) async => Left(ServerFailure()));
      return productBloc;
  },
  act: (bloc) => bloc.add(GetSingleProductEvent(tid)),
  expect: () => [ProductLoading(), ProductError()],
);



}

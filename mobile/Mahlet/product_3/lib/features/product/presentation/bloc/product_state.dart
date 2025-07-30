import 'package:equatable/equatable.dart';

import '../../domain/Entity/product_entity.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;

  const ProductLoaded(this.products);
}

class ProductCreated extends ProductState {
  final Product product;

  const ProductCreated(this.product);
}

class ProductUpdated extends ProductState {
  final Product product;

  const ProductUpdated(this.product);
}

class SingleProduct extends ProductState {
  final Product product;

  const SingleProduct(this.product);
}

class ProductDeleted extends ProductState {}

class ProductError extends ProductState {}

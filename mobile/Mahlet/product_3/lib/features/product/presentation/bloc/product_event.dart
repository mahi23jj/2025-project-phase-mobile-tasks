import 'package:equatable/equatable.dart';

import '../../domain/Entity/product_entity.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class LoadAllProductsEvent extends ProductEvent {}

class GetSingleProductEvent extends ProductEvent {
  final String id;
  GetSingleProductEvent(this.id);
}

class CreateProductEvent extends ProductEvent {
  final Product product;
  CreateProductEvent(this.product);
}

class UpdateProductEvent extends ProductEvent {
  final String id;
  final Product product;
  UpdateProductEvent(this.id, this.product);
}

class DeleteProductEvent extends ProductEvent {
  final String id;
  DeleteProductEvent(this.id);
}

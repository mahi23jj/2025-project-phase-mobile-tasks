import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

import '../../domain/usecase/create_product.dart';
import '../../domain/usecase/delete_Product.dart';
import '../../domain/usecase/update_product.dart';
import '../../domain/usecase/view_all_product.dart';
import '../../domain/usecase/view_single_product.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  late CreateProduct createProduct;
  late DeleteProduct deleteProduct;
  late UpdateProduct updateProduct;
  late ViewAllProduct viewAllProduct;
  late ViewSingleProduct viewSingleProduct;

  ProductBloc({
    required this.createProduct,
    required this.deleteProduct,
    required this.updateProduct,
    required this.viewAllProduct,
    required this.viewSingleProduct,
  }) : super(ProductInitial()) {
    on<CreateProductEvent>((event, emit) async {
      if (state is ProductInitial) {
        emit(ProductLoading());
        final result = await createProduct.call(event.product);

        result.fold(
          (l) => emit(ProductError()),
          (r) => emit(ProductCreated(r)),
        );
      }
    });
    on<DeleteProductEvent>((event, emit) async {
      if (state is ProductInitial) {
        emit(ProductLoading());

        final result = await deleteProduct.call(event.id);

        result.fold((l) => emit(ProductError()), (r) => emit(ProductDeleted()));
      }
    });
    on<LoadAllProductsEvent>((event, emit) async {
      if (state is ProductInitial) {
        emit(ProductLoading());

        final result = await viewAllProduct.call();

        result.fold((l) => emit(ProductError()), (r) => emit(ProductLoaded(r)));
      }
    });
    on<UpdateProductEvent>((event, emit) async {
      if (state is ProductInitial) {
        emit(ProductLoading());

        final result = await updateProduct.call(event.id, event.product);

        result.fold(
          (l) => emit(ProductError()),
          (r) => emit(ProductUpdated(r)),
        );
      }
    });
    on<GetSingleProductEvent>((event, emit) async {
      if (state is ProductInitial) {
        emit(ProductLoading());

        final result = await viewSingleProduct.call(event.id);

        result.fold((l) => emit(ProductError()), (r) => emit(SingleProduct(r)));
      }
    });
  }
}

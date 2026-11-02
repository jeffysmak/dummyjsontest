import 'package:dummyjsonexample/features/products/models/product.dart';
import 'package:dummyjsonexample/features/products/service/products_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsState extends Equatable {
  const ProductDetailsState({this.loading = false, this.product, this.error});

  final bool loading;
  final Product? product;
  final String? error;

  @override
  List<Object?> get props => [loading, product, error];

  ProductDetailsState copyWith({bool? loading, Product? product, String? error}) {
    return ProductDetailsState(loading: loading ?? this.loading, product: product ?? this.product, error: error ?? this.error);
  }
}

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit(this._service) : super(const ProductDetailsState());
  final ProductsService _service;

  Future<void> load(String id) async {
    emit(state.copyWith(loading: true));
    final result = await _service.getProduct(id);
    if (isClosed) return;
    result.when(
      success: (product) => emit(state.copyWith(product: product, loading: false)),
      failure: (error) => emit(state.copyWith(error: error.message, loading: false)),
    );
  }
}

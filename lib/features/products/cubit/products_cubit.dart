import 'package:dummyjsonexample/features/products/controller/products_controller.dart';
import 'package:dummyjsonexample/features/products/models/product.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsState extends Equatable {
  const ProductsState({this.products = const [], this.loading = false, this.error, this.hasMore = true});

  final List<Product> products;
  final bool loading, hasMore;
  final String? error;

  @override
  List<Object?> get props => [products, loading, hasMore, error];

  ProductsState copyWith({List<Product>? products, bool? loading, bool? hasMore, String? error, bool clearError = false}) {
    return ProductsState(
      products: products ?? this.products,
      loading: loading ?? this.loading,
      error: clearError ? null : error ?? this.error,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this._controller) : super(const ProductsState());
  final ProductsController _controller;

  Future<void> initializeProducts() async {
    final currentState = state;
    emit(currentState.copyWith(loading: true, products: const [], clearError: true));
    final result = await _controller.loadPage(const []);
    if (isClosed) return;
    result.when(
      success: (page) {
        debugPrint('Loaded: ${page.products.length}');
        return emit(
          currentState.copyWith(products: page.products, hasMore: page.products.length < page.total, loading: false, clearError: true),
        );
      },
      failure: (error) =>
          emit(currentState.copyWith(products: currentState.products, error: error.message, hasMore: currentState.hasMore)),
    );
  }

  Future<void> paginateProducts() async {
    if (state.loading || !state.hasMore) return;

    final currentState = state;
    emit(currentState.copyWith(loading: true, clearError: true));

    final result = await _controller.loadPage(currentState.products);
    if (isClosed) return;

    result.when(
      success: (page) {
        debugPrint('Paginated: ${page.products.length}');
        return emit(
          currentState.copyWith(products: page.products, hasMore: page.products.length < page.total, loading: false, clearError: true),
        );
      },
      failure: (error) => emit(currentState.copyWith(products: currentState.products, error: error.message)),
    );
  }
}

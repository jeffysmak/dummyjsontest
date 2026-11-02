import 'package:dummyjsonexample/core/services/api_service.dart';
import 'package:dummyjsonexample/core/errors/app_failures.dart';
import 'package:dummyjsonexample/core/result.dart';
import 'package:dummyjsonexample/features/products/models/product.dart';
import 'package:dummyjsonexample/features/products/models/product_page.dart';

class ProductsService {
  const ProductsService(this._api);

  final ApiService _api;

  Future<Result<ProductPage>> getPage({required int limit, required int skip}) async {
    final result = await _api.get('/products', query: {'limit': '$limit', 'skip': '$skip'});
    return result.when(
      failure: (error) => Failure(error),
      success: (data) {
        try {
          return Success(ProductPage.fromJson(data));
        } catch (_) {
          return const Failure(UnknownFailure('Could not read the products.'));
        }
      },
    );
  }

  Future<Result<Product>> getProduct(String id) async {
    final result = await _api.get('/products/$id');
    return result.when(
      failure: (error) => Failure(error),
      success: (data) {
        try {
          return Success(Product.fromJson(data));
        } catch (_) {
          return const Failure(UnknownFailure('Could not read this product.'));
        }
      },
    );
  }
}

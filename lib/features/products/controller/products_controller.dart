import 'package:dummyjsonexample/core/result.dart';
import 'package:dummyjsonexample/features/products/models/product.dart';
import 'package:dummyjsonexample/features/products/models/product_page.dart';
import 'package:dummyjsonexample/features/products/service/products_service.dart';

class ProductsController {
  const ProductsController(this._service);

  final ProductsService _service;
  static const _pageSize = 10;

  Future<Result<ProductPage>> loadPage(List<Product> current) async {
    final result = await _service.getPage(limit: _pageSize, skip: current.length);
    return result.when(
      failure: (error) => Failure(error),
      success: (page) => Success(
        ProductPage(products: List.from([...current, ...page.products]), total: page.products.isEmpty ? current.length : page.total),
      ),
    );
  }
}

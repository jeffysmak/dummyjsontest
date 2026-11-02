import 'package:dummyjsonexample/features/products/models/product.dart';
import 'package:equatable/equatable.dart';

class ProductPage extends Equatable {
  const ProductPage({required this.products, required this.total});

  final List<Product> products;
  final int total;

  factory ProductPage.fromJson(Map<String, dynamic> json) => ProductPage(
    products: List.of((json['products'] as List).map((item) => Product.fromJson(item as Map<String, dynamic>))),
    total: json['total'] as int,
  );

  Map<String, dynamic> toJson() => {'products': products.map((product) => product.toJson()).toList(), 'total': total};

  @override
  List<Object?> get props => [products, total];
}

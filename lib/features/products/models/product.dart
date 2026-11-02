import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.thumbnail,
    required this.category,
    required this.rating,
  });

  final int id;
  final String title;
  final String description;
  final double price;
  final String thumbnail;
  final String category;
  final double rating;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'] as int,
    title: json['title'] as String,
    description: json['description'] as String? ?? '',
    price: (json['price'] as num).toDouble(),
    thumbnail: json['thumbnail'] as String? ?? '',
    category: json['category'] as String? ?? '',
    rating: (json['rating'] as num?)?.toDouble() ?? 0,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'price': price,
    'thumbnail': thumbnail,
    'category': category,
    'rating': rating,
  };

  @override
  List<Object?> get props => [id, title, description, price, thumbnail, category, rating];
}

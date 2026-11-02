import 'package:dummyjsonexample/core/theme/app_spacing.dart';
import 'package:dummyjsonexample/features/products/cubit/product_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsDetailsPage extends StatelessWidget {
  const ProductsDetailsPage({super.key, required this.id});

  static const route = ':id';
  final String id;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Product details')),
      body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          final product = state.product;
          if (state.error != null || product == null) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(state.error ?? 'Could not load this product.'),
                  AppSpacing.gapMd,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                    child: OutlinedButton(
                      onPressed: () => context.read<ProductDetailsCubit>().load(id),
                      child: const Text('Try again'),
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView(
            padding: AppSpacing.edgeInsetsLg,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  product.thumbnail,
                  height: 260,
                  fit: BoxFit.contain,
                  errorBuilder: (_, _, _) => const SizedBox(height: 260, child: Icon(Icons.image_not_supported_outlined, size: 48)),
                ),
              ),
              AppSpacing.gapLg,
              Text(product.category.toUpperCase(), style: theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.primary)),
              AppSpacing.gapSm,
              Text(product.title, style: theme.textTheme.headlineMedium),
              AppSpacing.gapMd,
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: theme.textTheme.headlineSmall?.copyWith(color: theme.colorScheme.primary),
              ),
              AppSpacing.gapSm,
              Row(
                children: [
                  Icon(Icons.star, size: 20, color: theme.colorScheme.secondary),
                  const SizedBox(width: 4),
                  Text(product.rating.toStringAsFixed(1)),
                ],
              ),
              AppSpacing.gapLg,
              Text('Description', style: theme.textTheme.titleLarge),
              AppSpacing.gapSm,
              Text(product.description, style: theme.textTheme.bodyLarge),
            ],
          );
        },
      ),
    );
  }
}

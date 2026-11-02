import 'package:dummyjsonexample/core/build_context_extensions.dart';
import 'package:dummyjsonexample/core/theme/app_spacing.dart';
import 'package:dummyjsonexample/core/theme/theme_cubit.dart';
import 'package:dummyjsonexample/features/login/cubit/auth_cubit.dart';
import 'package:dummyjsonexample/features/products/cubit/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProductsListPage extends StatefulWidget {
  const ProductsListPage({super.key});

  static const route = '/products';

  @override
  State<ProductsListPage> createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  final _scrollController = ScrollController();
  bool _pageRequestedDuringScroll = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_pageRequestedDuringScroll && _scrollController.position.extentAfter < 300) {
      final cubit = context.read<ProductsCubit>();
      if (cubit.state.hasMore && !cubit.state.loading && cubit.state.error == null) {
        _pageRequestedDuringScroll = true;
        cubit.paginateProducts();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.failure) {
          context.showError(message: state.message ?? 'Could not sign out.');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Products'),
          actions: [
            IconButton(
              tooltip: 'Toggle theme',
              onPressed: () => context.read<ThemeCubit>().toggleTheme(),
              icon: const Icon(Icons.brightness_6_outlined),
            ),
            IconButton(tooltip: 'Sign out', onPressed: () => context.read<AuthCubit>().logout(), icon: const Icon(Icons.logout)),
          ],
        ),
        body: BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            final cubit = context.read<ProductsCubit>();
            if (state.loading && state.products.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.error != null && state.products.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.error!, textAlign: TextAlign.center),
                    AppSpacing.gapMd,
                    OutlinedButton(onPressed: () => cubit.initializeProducts(), child: const Text('Try again')),
                  ],
                ),
              );
            }
            return NotificationListener<ScrollStartNotification>(
              onNotification: (notification) {
                if (notification.depth == 0) {
                  _pageRequestedDuringScroll = false;
                  _onScroll();
                }
                return false;
              },
              child: RefreshIndicator(
                onRefresh: cubit.initializeProducts,
                child: ListView.builder(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: AppSpacing.edgeInsetsMd,
                  itemCount: state.products.length + 1,
                  itemBuilder: (context, index) {
                    if (index == state.products.length) {
                      if (state.loading) {
                        return const Padding(
                          padding: AppSpacing.edgeInsetsLg,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      if (state.error != null) {
                        return Center(
                          child: Column(
                            children: [
                              Text(state.error ?? 'Errorrrrrrr', textAlign: TextAlign.center),
                              TextButton(
                                onPressed: state.error != null ? cubit.initializeProducts : cubit.paginateProducts,
                                child: const Text('Try again'),
                              ),
                            ],
                          ),
                        );
                      }
                      if (state.products.isEmpty) {
                        return const Padding(
                          padding: AppSpacing.edgeInsetsXl,
                          child: Center(child: Text('No products found. Pull down to refresh.')),
                        );
                      }
                      return const SizedBox.shrink();
                    }
                    final product = state.products[index];
                    return Card(
                      child: ListTile(
                        contentPadding: AppSpacing.edgeInsetsSm,
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            product.thumbnail,
                            width: 64,
                            height: 64,
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) =>
                                const SizedBox(width: 64, height: 64, child: Icon(Icons.image_not_supported_outlined)),
                          ),
                        ),
                        title: Text(product.title, maxLines: 2, overflow: TextOverflow.ellipsis),
                        subtitle: Text('\$${product.price.toStringAsFixed(2)}', style: TextStyle(color: theme.colorScheme.primary)),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => context.push('/products/${product.id}'),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

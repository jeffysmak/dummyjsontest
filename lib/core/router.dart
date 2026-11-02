import 'dart:async';

import 'package:dummyjsonexample/features/login/cubit/auth_cubit.dart';
import 'package:dummyjsonexample/features/login/login_page.dart';
import 'package:dummyjsonexample/features/products/cubit/product_details_cubit.dart';
import 'package:dummyjsonexample/features/products/cubit/products_cubit.dart';
import 'package:dummyjsonexample/features/products/products_details_page.dart';
import 'package:dummyjsonexample/features/products/products_list_page.dart';
import 'package:dummyjsonexample/features/splash/splash_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AuthRouterRefresh extends ChangeNotifier {
  AuthRouterRefresh(AuthCubit authCubit) {
    _subscription = authCubit.stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<AuthState> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

GoRouter createRouter(
  AuthCubit authCubit,
  AuthRouterRefresh authRefresh,
  ProductsCubit Function() productsCubit,
  ProductDetailsCubit Function() detailsCubit,
) => GoRouter(
  initialLocation: SplashPage.route,
  refreshListenable: authRefresh,
  redirect: (context, state) {
    final auth = authCubit.state;
    final signedIn = auth.isSignedIn;
    final location = state.uri.path;
    if (auth.status == AuthStatus.initial) {
      return location == SplashPage.route ? null : SplashPage.route;
    }
    if (location == SplashPage.route && (auth.status == AuthStatus.loading || auth.status == AuthStatus.failure)) {
      return null;
    }
    if (!signedIn) return location == LoginPage.route ? null : LoginPage.route;
    if (location == SplashPage.route || location == LoginPage.route) {
      return ProductsListPage.route;
    }
    return null;
  },
  routes: [
    GoRoute(
      path: SplashPage.route,
      pageBuilder: (_, _) => const NoTransitionPage(child: SplashPage()),
    ),
    GoRoute(
      path: LoginPage.route,
      pageBuilder: (_, _) => const NoTransitionPage(child: LoginPage()),
    ),
    GoRoute(
      path: ProductsListPage.route,
      builder: (_, _) => BlocProvider(create: (_) => productsCubit()..initializeProducts(), child: const ProductsListPage()),
      routes: [
        GoRoute(
          path: ProductsDetailsPage.route,
          builder: (_, state) {
            final id = state.pathParameters['id']!;
            return BlocProvider(
              create: (_) => detailsCubit()..load(id),
              child: ProductsDetailsPage(id: id),
            );
          },
        ),
      ],
    ),
  ],
);

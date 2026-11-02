import 'package:dummyjsonexample/core/services/api_service.dart';
import 'package:dummyjsonexample/core/router.dart';
import 'package:dummyjsonexample/core/services/alert_service.dart';
import 'package:dummyjsonexample/core/storage/token_storage.dart';
import 'package:dummyjsonexample/core/theme/theme_cubit.dart';
import 'package:dummyjsonexample/features/login/controller/auth_controller.dart';
import 'package:dummyjsonexample/features/login/cubit/auth_cubit.dart';
import 'package:dummyjsonexample/features/login/service/auth_service.dart';
import 'package:dummyjsonexample/features/products/controller/products_controller.dart';
import 'package:dummyjsonexample/features/products/cubit/product_details_cubit.dart';
import 'package:dummyjsonexample/features/products/cubit/products_cubit.dart';
import 'package:dummyjsonexample/features/products/service/products_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final GetIt di = GetIt.instance;

Future<void> setupDependencyInjection() async {
  // Services
  final preferences = await SharedPreferences.getInstance();
  di.registerSingleton<SharedPreferences>(preferences);
  di.registerLazySingleton<AlertService>(() => AlertService());
  di.registerLazySingleton<http.Client>(() => http.Client());
  di.registerLazySingleton<ApiService>(() => ApiService(di<http.Client>()));
  di.registerLazySingleton<TokenStorage>(() => const TokenStorage(FlutterSecureStorage()));
  di.registerLazySingleton<AuthService>(() => AuthService(di<ApiService>()));
  di.registerLazySingleton<ProductsService>(() => ProductsService(di<ApiService>()));

  // Controllers
  di.registerLazySingleton<AuthController>(() => AuthController(di<AuthService>(), di<TokenStorage>()));
  di.registerLazySingleton<ProductsController>(() => ProductsController(di<ProductsService>()));

  // Cubits / Blocs
  di.registerLazySingleton<ThemeCubit>(() => ThemeCubit(di<SharedPreferences>()));
  di.registerLazySingleton<AuthCubit>(() => AuthCubit(di<AuthController>()), dispose: (cubit) => cubit.close());
  di.registerLazySingleton<AuthRouterRefresh>(() => AuthRouterRefresh(di<AuthCubit>()), dispose: (refresh) => refresh.dispose());
  di.registerFactory<ProductsCubit>(() => ProductsCubit(di<ProductsController>()));
  di.registerFactory<ProductDetailsCubit>(() => ProductDetailsCubit(di<ProductsService>()));

  di.registerLazySingleton<GoRouter>(
    () => createRouter(di<AuthCubit>(), di<AuthRouterRefresh>(), () => di<ProductsCubit>(), () => di<ProductDetailsCubit>()),
    dispose: (router) => router.dispose(),
  );
}

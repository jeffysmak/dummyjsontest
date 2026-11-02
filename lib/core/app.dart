import 'package:dummyjsonexample/core/app_strings.dart';
import 'package:dummyjsonexample/core/services/alert_service.dart';
import 'package:dummyjsonexample/core/theme/app_theme.dart';
import 'package:dummyjsonexample/core/theme/theme_cubit.dart';
import 'package:dummyjsonexample/features/login/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'di.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeCubit themeCubit = di<ThemeCubit>();
  final AuthCubit authCubit = di<AuthCubit>();
  final GoRouter router = di<GoRouter>();
  final AlertService alertService = di<AlertService>();

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider.value(value: themeCubit),
      BlocProvider.value(value: authCubit),
    ],
    child: BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) => MaterialApp.router(
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        scaffoldMessengerKey: alertService.messengerKey,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: themeMode,
      ),
    ),
  );
}

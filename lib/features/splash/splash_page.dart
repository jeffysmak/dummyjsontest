import 'package:dummyjsonexample/core/theme/app_spacing.dart';
import 'package:dummyjsonexample/features/login/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const route = '/';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _initializeSession();
  }

  Future<void> _initializeSession() async {
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    context.read<AuthCubit>().initSession();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<AuthCubit, AuthState>(
    builder: (context, state) => Scaffold(
      body: Center(
        child: state.status == AuthStatus.failure
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(state.message ?? ''),
                  OutlinedButton(onPressed: () => context.read<AuthCubit>().initSession(), child: const Text('Try again')),
                ],
              )
            : Center(
                child: Column(
                  mainAxisSize: .min,
                  mainAxisAlignment: .center,
                  children: [
                    Text("Splash Screen"),
                    const SizedBox(height: AppSpacing.md),
                    const CircularProgressIndicator(),
                  ],
                ),
              ),
      ),
    ),
  );
}

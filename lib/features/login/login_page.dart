import 'package:dummyjsonexample/core/build_context_extensions.dart';
import 'package:dummyjsonexample/core/theme/app_spacing.dart';
import 'package:dummyjsonexample/features/login/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const route = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState?.validate() == true) {
      context.read<AuthCubit>().login(_username.text.trim(), _password.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final loading = state.status == AuthStatus.loading;
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: AppSpacing.edgeInsetsLg,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Icon(Icons.shopping_bag_outlined, size: 52, color: context.theme.colorScheme.primary),
                        AppSpacing.gapLg,
                        Text('Welcome back', style: context.theme.textTheme.headlineMedium, textAlign: TextAlign.center),
                        AppSpacing.gapSm,
                        Text(
                          'Sign in to explore the products.',
                          textAlign: TextAlign.center,
                          style: context.theme.textTheme.bodyLarge,
                        ),
                        AppSpacing.gapXxl,
                        TextFormField(
                          controller: _username,
                          enabled: !loading,
                          textInputAction: TextInputAction.next,
                          autocorrect: false,
                          decoration: const InputDecoration(labelText: 'Username', prefixIcon: Icon(Icons.person_outline)),
                          validator: (value) => value == null || value.trim().isEmpty ? 'Enter your username' : null,
                        ),
                        AppSpacing.gapMd,
                        TextFormField(
                          controller: _password,
                          enabled: !loading,
                          obscureText: state.obscurePassword,
                          onFieldSubmitted: (_) => _login(),
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              onPressed: context.read<AuthCubit>().togglePassword,
                              icon: Icon(state.obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                              tooltip: state.obscurePassword ? 'Show password' : 'Hide password',
                            ),
                          ),
                          validator: (value) => value == null || value.isEmpty ? 'Enter your password' : null,
                        ),
                        if (state.status == AuthStatus.failure) ...[
                          AppSpacing.gapMd,
                          Text(state.message ?? 'Unable to sign in.', style: TextStyle(color: context.theme.colorScheme.error)),
                        ],
                        AppSpacing.gapLg,
                        ElevatedButton(
                          onPressed: loading ? null : _login,
                          child: loading
                              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                              : const Text('Sign in'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

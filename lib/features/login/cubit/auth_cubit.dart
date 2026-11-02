import 'package:dummyjsonexample/core/models/auth_user.dart';
import 'package:dummyjsonexample/features/login/controller/auth_controller.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._controller) : super(const AuthState());
  final AuthController _controller;

  void togglePassword() => emit(state.copyWith(obscurePassword: !state.obscurePassword));

  Future<void> initSession() async {
    final currentState = state;
    if (currentState.status == AuthStatus.loading) return;
    emit(currentState.copyWith(status: AuthStatus.loading));
    final result = await _controller.initializeSession();
    if (isClosed) return;
    result.when(
      success: (user) {
        if (user == null) {
          emit(currentState.copyWith(status: AuthStatus.signedOut));
        } else {
          emit(currentState.copyWith(status: AuthStatus.signedIn, user: user));
        }
      },
      failure: (error) => emit(currentState.copyWith(status: AuthStatus.failure, message: error.message)),
    );
  }

  Future<void> refreshSession() async {
    if (state.status == AuthStatus.loading) return;
    emit(AuthState(status: AuthStatus.loading, user: state.user));
    final result = await _controller.refreshSession();
    if (isClosed) return;
    result.when(
      success: (user) => emit(AuthState(status: user != null ? AuthStatus.signedIn : AuthStatus.signedOut, user: user)),
      failure: (error) => emit(AuthState(status: AuthStatus.failure, message: error.message, user: state.user)),
    );
  }

  Future<void> login(String username, String password) async {
    final currentState = state;
    if (currentState.status == AuthStatus.loading) return;
    emit(currentState.copyWith(status: AuthStatus.loading));
    final result = await _controller.login(username, password);
    if (isClosed) return;
    result.when(
      success: (user) => emit(currentState.copyWith(status: AuthStatus.signedIn, user: user)),
      failure: (error) => emit(currentState.copyWith(status: AuthStatus.failure, message: error.message)),
    );
  }

  Future<void> logout() async {
    if (state.status == AuthStatus.loading) return;
    emit(AuthState(status: AuthStatus.loading, user: state.user));
    final result = await _controller.logout();
    if (isClosed) return;
    result.when(
      success: (_) => emit(const AuthState(status: AuthStatus.signedOut)),
      failure: (error) => emit(AuthState(status: AuthStatus.failure, message: error.message, user: state.user)),
    );
  }
}

part of 'auth_cubit.dart';

enum AuthStatus { initial, loading, signedIn, signedOut, failure }

class AuthState extends Equatable {
  const AuthState({this.status = AuthStatus.initial, this.message, this.user, this.obscurePassword = true});

  final AuthStatus status;
  final String? message;
  final AuthUser? user;
  final bool obscurePassword;

  @override
  List<Object?> get props => [status, message, obscurePassword, user];

  bool get isSignedIn => user != null;

  AuthState copyWith({AuthStatus? status, String? message, bool? signedIn, AuthUser? user, bool? obscurePassword}) {
    return AuthState(
      status: status ?? this.status,
      message: message ?? this.message,
      user: user ?? this.user,
      obscurePassword: obscurePassword ?? this.obscurePassword,
    );
  }
}

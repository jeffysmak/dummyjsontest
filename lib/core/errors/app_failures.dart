import 'package:equatable/equatable.dart';

sealed class AppFailure extends Equatable {
  const AppFailure(this.message, [this.code]);

  final String message;
  final String? code;

  @override
  List<Object?> get props => [message, code];
}

final class AuthFailure extends AppFailure {
  const AuthFailure([String? message, String? code]) : super(message ?? 'Authentication failed', code);
}

final class ServerFailure extends AppFailure {
  const ServerFailure([String? message, String? code]) : super(message ?? 'Server error occurred', code);
}

final class ValidationFailure extends AppFailure {
  const ValidationFailure(super.message, [super.code]);
}

final class NotFoundFailure extends AppFailure {
  const NotFoundFailure([String? message, String? code]) : super(message ?? 'Resource not found', code);
}

final class PermissionFailure extends AppFailure {
  const PermissionFailure([String? message, String? code]) : super(message ?? 'Permission denied', code);
}

final class NetworkFailure extends AppFailure {
  const NetworkFailure([String? message, String? code]) : super(message ?? 'Network connection error', code);
}

final class UnknownFailure extends AppFailure {
  const UnknownFailure([String? message, String? code]) : super(message ?? 'An unexpected error occurred', code);
}

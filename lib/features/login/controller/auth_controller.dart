import 'package:dummyjsonexample/core/errors/app_failures.dart';
import 'package:dummyjsonexample/core/models/auth_tokens.dart';
import 'package:dummyjsonexample/core/models/auth_user.dart';
import 'package:dummyjsonexample/core/result.dart';
import 'package:dummyjsonexample/core/storage/token_storage.dart';
import 'package:dummyjsonexample/features/login/service/auth_service.dart';

class AuthController {
  const AuthController(this._authService, this._storage);

  final AuthService _authService;
  final TokenStorage _storage;

  Future<Result<AuthUser?>> initializeSession() async {
    final stored = await _storage.read();
    if (stored.isFailure) return Failure(stored.failureOrNull!);
    final tokens = stored.dataOrNull;
    if (tokens == null) return const Success(null);
    return _getProfile(tokens);
  }

  Future<Result<AuthUser?>> _getProfile(AuthTokens tokens) async {
    final profile = await _authService.getProfile(tokens.accessToken);
    return profile.when(
      failure: (failure) {
        if (_isUnauthorized(failure)) {
          return _refreshAndGetProfile(tokens);
        }
        return Failure(failure);
      },
      success: (profile) {
        return Success(profile);
      },
    );
  }

  Future<Result<AuthUser?>> _refreshAndGetProfile(AuthTokens tokens) async {
    if (tokens.refreshToken.isEmpty) return _clearSession();
    final refreshed = await _authService.refresh(tokens.refreshToken);
    if (refreshed.isFailure) {
      final error = refreshed.failureOrNull!;
      return _isUnauthorized(error) ? _clearSession() : Failure(error);
    }
    final newTokens = refreshed.dataOrNull!;
    final saved = await _storage.write(newTokens);
    if (saved.isFailure) return Failure(saved.failureOrNull!);
    final profile = await _authService.getProfile(newTokens.accessToken);
    if (profile.isSuccess) return Success(profile.dataOrNull!);
    final error = profile.failureOrNull!;
    return _isUnauthorized(error) ? _clearSession() : Failure(error);
  }

  Future<Result<AuthUser>> login(String username, String password) async {
    final loginResult = await _authService.login(username.trim(), password);
    final tokens = loginResult.dataOrNull;
    if (tokens == null) return Failure(loginResult.failureOrNull!);
    final profile = await _authService.getProfile(tokens.accessToken);
    if (profile.isFailure) return profile;
    final saved = await _storage.write(tokens);
    if (saved.isFailure) return Failure(saved.failureOrNull!);
    return profile;
  }

  Future<Result<AuthUser?>> refreshSession() async {
    final stored = await _storage.read();
    if (stored.isFailure) return Failure(stored.failureOrNull!);
    final tokens = stored.dataOrNull;
    if (tokens == null) return const Success(null);
    return _refreshAndGetProfile(tokens);
  }

  Future<Result<AuthUser?>> _clearSession() async {
    final result = await _storage.delete();
    return result.when(failure: (error) => Failure(error), success: (_) => const Success(null));
  }

  bool _isUnauthorized(AppFailure error) => error is AuthFailure && (error.code == '401' || error.code == '403');

  Future<Result<void>> logout() => _storage.delete();
}

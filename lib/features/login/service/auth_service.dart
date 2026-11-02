import 'package:dummyjsonexample/core/services/api_service.dart';
import 'package:dummyjsonexample/core/errors/app_failures.dart';
import 'package:dummyjsonexample/core/models/auth_tokens.dart';
import 'package:dummyjsonexample/core/models/auth_user.dart';
import 'package:dummyjsonexample/core/result.dart';

class AuthService {
  const AuthService(this._api);

  final ApiService _api;

  Future<Result<AuthTokens>> login(String username, String password) async {
    final result = await _api.post('/auth/login', {'username': username, 'password': password});
    return _parseTokens(result);
  }

  Future<Result<AuthTokens>> refresh(String refreshToken) async {
    final result = await _api.post('/auth/refresh', {'refreshToken': refreshToken});
    return _parseTokens(result);
  }

  Future<Result<AuthUser>> getProfile(String accessToken) async {
    final result = await _api.get('/auth/me', headers: {'Authorization': 'Bearer $accessToken'});
    return result.when(
      failure: (error) => Failure(error),
      success: (data) {
        try {
          return Success(AuthUser.fromJson(data));
        } catch (_) {
          return const Failure(UnknownFailure('Could not read profile. Please try again.'));
        }
      },
    );
  }

  Result<AuthTokens> _parseTokens(Result<Map<String, dynamic>> result) => result.when(
    failure: (error) => Failure(error),
    success: (data) {
      try {
        return Success(AuthTokens.fromJson(data));
      } catch (_) {
        return const Failure(UnknownFailure('Could not read the session. Please try again.'));
      }
    },
  );
}

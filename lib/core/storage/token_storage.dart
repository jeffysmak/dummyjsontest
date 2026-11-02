import 'dart:convert';

import 'package:dummyjsonexample/core/errors/app_failures.dart';
import 'package:dummyjsonexample/core/models/auth_tokens.dart';
import 'package:dummyjsonexample/core/result.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  const TokenStorage(this._storage);

  final FlutterSecureStorage _storage;
  static const _key = 'auth_tokens';
  static const _legacyKey = 'access_token';

  Future<Result<AuthTokens?>> read() async {
    try {
      final value = await _storage.read(key: _key);
      if (value == null) {
        // Older installations only saved an access token; validate it once.
        final accessToken = await _storage.read(key: _legacyKey);
        return Success(accessToken == null || accessToken.isEmpty ? null : AuthTokens(accessToken: accessToken, refreshToken: ''));
      }
      return Success(AuthTokens.fromJson(jsonDecode(value) as Map<String, dynamic>));
    } catch (_) {
      return const Failure(UnknownFailure('Could not read session. Please try again.'));
    }
  }

  Future<Result<void>> write(AuthTokens tokens) async {
    try {
      await _storage.write(key: _key, value: jsonEncode(tokens.toJson()));
      await _storage.delete(key: _legacyKey);
      return const Success(null);
    } catch (_) {
      return const Failure(UnknownFailure('Could not save session. Please try again.'));
    }
  }

  Future<Result<void>> delete() async {
    try {
      await _storage.delete(key: _key);
      await _storage.delete(key: _legacyKey);
      return const Success(null);
    } catch (_) {
      return const Failure(UnknownFailure('Could not sign out. Please try again.'));
    }
  }
}

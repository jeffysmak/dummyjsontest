import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dummyjsonexample/core/errors/app_failures.dart';
import 'package:dummyjsonexample/core/result.dart';
import 'package:http/http.dart' as http;

class ApiService {
  const ApiService(this._client);

  final http.Client _client;
  static const _baseUrl = 'https://dummyjson.com';

  Future<Result<Map<String, dynamic>>> get(String path, {Map<String, String>? query, Map<String, String>? headers}) =>
      _request(() => _client.get(Uri.parse('$_baseUrl$path').replace(queryParameters: query), headers: headers));

  Future<Result<Map<String, dynamic>>> post(String path, Map<String, dynamic> body) =>
      _request(() => _client.post(Uri.parse('$_baseUrl$path'), headers: {'Content-Type': 'application/json'}, body: jsonEncode(body)));

  Future<Result<Map<String, dynamic>>> _request(Future<http.Response> Function() request) async {
    try {
      final response = await request().timeout(const Duration(seconds: 15));
      if (response.statusCode < 200 || response.statusCode >= 300) {
        final code = response.statusCode.toString();
        final message = _errorMessage(response.body);
        final failure = response.statusCode == 401 || response.statusCode == 403
            ? AuthFailure(message ?? 'Session has expired.', code)
            : ServerFailure(message ?? 'Something went wrong. Please try again.', code);
        return Failure(failure);
      }
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return Success(data);
    } on SocketException {
      return const Failure(NetworkFailure('Please check your internet connection and try again.'));
    } on http.ClientException {
      return const Failure(NetworkFailure('Please check your internet connection and try again.'));
    } on TimeoutException {
      return const Failure(NetworkFailure('The request timed out. Please try again.'));
    } catch (_) {
      return const Failure(UnknownFailure('Something went wrong. Please try again.'));
    }
  }

  String? _errorMessage(String body) {
    try {
      final data = jsonDecode(body);
      return data is Map<String, dynamic> && data['message'] is String ? data['message'] as String : null;
    } catch (_) {
      return null;
    }
  }
}

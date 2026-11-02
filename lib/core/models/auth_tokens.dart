import 'package:equatable/equatable.dart';

class AuthTokens extends Equatable {
  const AuthTokens({required this.accessToken, required this.refreshToken});

  final String accessToken;
  final String refreshToken;

  factory AuthTokens.fromJson(Map<String, dynamic> json) {
    final accessToken = (json['accessToken'] as String?) ?? '';
    final refreshToken = (json['refreshToken'] as String?) ?? '';
    if (accessToken.isEmpty || refreshToken.isEmpty) {
      throw const FormatException('Missing auth tokens');
    }
    return AuthTokens(accessToken: accessToken, refreshToken: refreshToken);
  }

  Map<String, dynamic> toJson() => {'accessToken': accessToken, 'refreshToken': refreshToken};

  @override
  List<Object?> get props => [accessToken, refreshToken];
}

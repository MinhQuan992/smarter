class AuthenticationResponse {
  final String token;
  final int expirationTime;

  const AuthenticationResponse({required this.token, required this.expirationTime});

  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) {
    return AuthenticationResponse(
        token: json['token'], expirationTime: json['expirationTime']);
  }
}

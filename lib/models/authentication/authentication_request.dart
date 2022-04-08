class AuthenticationRequest {
  final String email;
  final String password;

  const AuthenticationRequest({required this.email, required this.password});

  Map<String, String> toJson() {
    return {"email": email.trim(), "password": password.trim()};
  }
}

class AuthenticationRequest {
  String email;
  String password;

  AuthenticationRequest({required this.email, required this.password});

  Map<String, String> toJson() {
    return {"email": email.trim(), "password": password.trim()};
  }
}

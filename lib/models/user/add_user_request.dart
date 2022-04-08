class AddUserRequest {
  final String name;
  final String email;
  final String password;
  final String otp;

  const AddUserRequest(
      {required this.name,
      required this.email,
      required this.password,
      required this.otp});

  Map<String, String> toJson() {
    return {"name": name, "email": email, "password": password, "otp": otp};
  }
}

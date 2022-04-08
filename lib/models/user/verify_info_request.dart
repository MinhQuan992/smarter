class VerifyInfoRequest {
  final String name;
  final String email;

  const VerifyInfoRequest({required this.name, required this.email});

  Map<String, String> toJson() {
    return {"name": name, "email": email};
  }
}

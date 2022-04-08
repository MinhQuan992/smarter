class UserResponse {
  final int id;
  final String name;
  final String? gender;
  final String? dateOfBirth;
  final String? imageUrl;
  final String email;
  final String password;

  const UserResponse(
      {required this.id,
      required this.name,
      this.gender,
      this.dateOfBirth,
      this.imageUrl,
      required this.email,
      required this.password});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
        id: json["id"],
        name: json["name"],
        gender: json["gender"],
        dateOfBirth: json["dateOfBirth"],
        imageUrl: json["imageUrl"],
        email: json["email"],
        password: json["password"]);
  }
}

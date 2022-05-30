class ChangeProfileRequest {
  final String name;
  final String? imageUrl;
  final String? gender;
  final String? birthdate;
  final String? newPassword;
  final String? confirmedPassword;

  const ChangeProfileRequest(
      {required this.name,
      this.imageUrl,
      this.gender,
      this.birthdate,
      this.newPassword,
      this.confirmedPassword});

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "imageUrl": imageUrl,
      "gender": gender,
      "birthdate": birthdate,
      "newPassword": newPassword,
      "confirmedPassword": confirmedPassword
    };
  }
}

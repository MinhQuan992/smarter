class UserQuestionResponse {
  final int questionId;
  final String shortContent;
  final String? imageUrl;
  final bool? answered;
  final bool? favorite;
  final bool? answerCorrect;

  const UserQuestionResponse(
      {required this.questionId,
      required this.shortContent,
      this.imageUrl,
      this.answered,
      this.favorite,
      this.answerCorrect});

  factory UserQuestionResponse.fromJson(Map<String, dynamic> json) {
    return UserQuestionResponse(
        questionId: json["questionId"],
        shortContent: json["shortContent"],
        imageUrl: json["imageUrl"],
        answered: json["answered"],
        favorite: json["favorite"],
        answerCorrect: json["answerCorrect"]);
  }
}

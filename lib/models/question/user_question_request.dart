class UserQuestionRequest {
  final String content;
  final String answerA;
  final String answerB;
  final String answerC;
  final String answerD;
  final String correctAnswer;
  final String? imageUrl;
  final String? information;
  final String? reference;

  const UserQuestionRequest(
      {required this.content,
      required this.answerA,
      required this.answerB,
      required this.answerC,
      required this.answerD,
      required this.correctAnswer,
      this.imageUrl,
      this.information,
      this.reference});

  Map<String, dynamic> toJson() {
    return {
      "content": content,
      "answerA": answerA,
      "answerB": answerB,
      "answerC": answerC,
      "answerD": answerD,
      "correctAnswer": correctAnswer,
      "imageUrl": imageUrl,
      "information": information,
      "reference": reference
    };
  }
}

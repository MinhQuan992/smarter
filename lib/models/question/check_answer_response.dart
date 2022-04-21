class CheckAnswerResponse {
  final bool answerCorrect;

  const CheckAnswerResponse({required this.answerCorrect});

  factory CheckAnswerResponse.fromJson(Map<String, dynamic> json) {
    return CheckAnswerResponse(answerCorrect: json["answerCorrect"]);
  }
}

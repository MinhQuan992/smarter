class QuestionResponse {
  final int id;
  final String content;
  final String answerA;
  final String answerB;
  final String? answerC;
  final String? answerD;
  final String correctAnswer;
  final String? imageUrl;
  final String? information;
  final String? reference;
  final int? groupId;
  final bool? favorite;

  const QuestionResponse({
    required this.id,
    required this.content,
    required this.answerA,
    required this.answerB,
    this.answerC,
    this.answerD,
    required this.correctAnswer,
    this.imageUrl,
    this.information,
    this.reference,
    this.groupId,
    this.favorite,
  });

  factory QuestionResponse.fromJson(Map<String, dynamic> json) {
    return QuestionResponse(
      id: json["id"],
      content: json["content"],
      answerA: json["answerA"],
      answerB: json["answerB"],
      answerC: json["answerC"],
      answerD: json["answerD"],
      correctAnswer: json["correctAnswer"],
      imageUrl: json["imageUrl"],
      information: json["information"],
      reference: json["reference"],
      groupId: json["groupId"],
      favorite: json["favorite"],
    );
  }
}

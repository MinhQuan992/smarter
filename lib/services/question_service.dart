import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smarter/models/question/check_answer_response.dart';
import 'package:smarter/models/question/question_response.dart';
import 'package:http/http.dart' as http;
import '../common/constants.dart' as constants;

class QuestionService {
  const QuestionService();

  final FlutterSecureStorage _flutterSecureStorage =
      const FlutterSecureStorage();

  Future<QuestionResponse> getRandomQuestion() async {
    String? token = await _flutterSecureStorage.read(key: "token");
    final response = await http.get(
        Uri.parse("${constants.baseUrl}/questions/random-question"),
        headers: {"Authorization": "Bearer $token"});
    return QuestionResponse.fromJson(
        jsonDecode(const Utf8Decoder().convert(response.bodyBytes)));
  }

  Future<CheckAnswerResponse> checkAnswer(
      int questionId, String answerCode) async {
    String? token = await _flutterSecureStorage.read(key: "token");
    final response = await http.post(
        Uri.parse("${constants.baseUrl}/questions/check-answer/$questionId"),
        headers: {"Authorization": "Bearer $token"},
        body: {"chosenAnswer": answerCode});
    return CheckAnswerResponse.fromJson(jsonDecode(response.body));
  }
}

import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smarter/models/user_question/user_question_response.dart';
import 'package:http/http.dart' as http;
import '../common/constants.dart' as constants;

class UserQuestionService {
  const UserQuestionService();

  final FlutterSecureStorage _flutterSecureStorage =
      const FlutterSecureStorage();

  Future<List<UserQuestionResponse>> getQuestionsByGroupForUser(
      int groupId) async {
    String? token = await _flutterSecureStorage.read(key: "token");
    final response = await http.get(
        Uri.parse("${constants.baseUrl}/questions/get-for-user/group/$groupId"),
        headers: {"Authorization": "Bearer $token"});
    List jsonResponse =
        jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
    return jsonResponse
        .map((userQuestion) => UserQuestionResponse.fromJson(userQuestion))
        .toList();
  }

  Future<dynamic> getFavoriteQuestionsForUser() async {
    String? token = await _flutterSecureStorage.read(key: "token");
    final response = await http.get(
        Uri.parse("${constants.baseUrl}/questions/get-for-user/favorite"),
        headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      List jsonResponse =
          jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
      return jsonResponse
          .map((userQuestion) => UserQuestionResponse.fromJson(userQuestion))
          .toList();
    }
    return false;
  }
}

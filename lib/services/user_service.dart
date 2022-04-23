import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smarter/models/exception.dart';
import 'package:smarter/models/user/user_response.dart';
import 'package:smarter/models/user/add_user_request.dart';
import 'package:smarter/models/user/verify_info_request.dart';
import 'package:http/http.dart' as http;
import '../common/constants.dart' as constants;

class UserService {
  const UserService();

  final FlutterSecureStorage _flutterSecureStorage =
      const FlutterSecureStorage();

  Future<dynamic> verifyInfoAndGenerateOtp(VerifyInfoRequest request) async {
    final response = await http.post(
        Uri.parse("${constants.baseUrl}/users/signup/verify-info"),
        headers: {"Content-Type": "application/json"},
        body: json.encode(request));
    if (response.statusCode == 200) {
      return true;
    }
    return Exception.fromJson(
        jsonDecode(const Utf8Decoder().convert(response.bodyBytes)));
  }

  Future<dynamic> addUser(AddUserRequest request) async {
    final response = await http.post(
        Uri.parse("${constants.baseUrl}/users/signup/add-user"),
        headers: {"Content-Type": "application/json"},
        body: json.encode(request));
    if (response.statusCode == 201) {
      return UserResponse.fromJson(
          jsonDecode(const Utf8Decoder().convert(response.bodyBytes)));
    }
    return Exception.fromJson(
        jsonDecode(const Utf8Decoder().convert(response.bodyBytes)));
  }

  Future<UserResponse> getCurrentUser() async {
    String? token = await _flutterSecureStorage.read(key: "token");
    final response = await http.get(
        Uri.parse("${constants.baseUrl}/users/current-user"),
        headers: {"Authorization": "Bearer $token"});
    return UserResponse.fromJson(
        jsonDecode(const Utf8Decoder().convert(response.bodyBytes)));
  }
}

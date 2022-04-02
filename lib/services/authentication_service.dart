import 'dart:convert';

import 'package:smarter/models/authentication/authentication_request.dart';
import 'package:smarter/models/authentication/authentication_response.dart';
import 'package:http/http.dart' as http;
import '../common/constants.dart' as constants;

class AuthenticationService {
  const AuthenticationService();

  Future<AuthenticationResponse> authenticate(
      AuthenticationRequest request) async {
    final response = await http.post(
        Uri.parse("${constants.baseUrl}/authentication/login"),
        headers: {"Content-Type": "application/json"},
        body: json.encode(request));
    if (response.statusCode == 200) {
      return AuthenticationResponse.fromJson(jsonDecode(response.body));
    }
    return AuthenticationResponse.fromJson({"token": "", "expirationTime": 0});
  }
}

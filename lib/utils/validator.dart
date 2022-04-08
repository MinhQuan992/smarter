import '../common/constants.dart' as constants;

class Validator {
  const Validator();

  bool isEmailValid(String email) {
    RegExp regExp = RegExp(constants.emailPattern);
    return regExp.hasMatch(email);
  }

  bool isPasswordValid(String password) {
    RegExp regExp = RegExp(constants.passwordPattern);
    return regExp.hasMatch(password);
  }
}

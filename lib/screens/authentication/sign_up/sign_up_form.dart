import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smarter/models/exception.dart';
import 'package:smarter/models/user/verify_info_request.dart';
import 'package:smarter/screens/authentication/otp/input_otp.dart';
import 'package:smarter/services/user_service.dart';
import 'package:smarter/utils/toast_builder.dart';
import 'package:smarter/utils/validator.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool _hidePassword = true;
  final GlobalKey<FormState> _globalFormKey = GlobalKey<FormState>();
  final Validator _validator = const Validator();
  final ToastBuilder _toastBuilder = const ToastBuilder();

  late String _name, _email, _password;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _globalFormKey,
        child: Column(
          children: <Widget>[
            const Align(
              alignment: Alignment.topCenter,
              child: Text("Đăng ký",
                  style: TextStyle(color: Colors.black, fontSize: 30)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                keyboardType: TextInputType.name,
                maxLength: 100,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                validator: (input) => input!.isEmpty || input.trim().isEmpty
                    ? "Mời bạn nhập tên"
                    : null,
                onSaved: (input) => _name = input!.trim(),
                decoration:
                    _buildDecoration("Tên của bạn", Icons.person, false),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                validator: (input) => input!.isEmpty || input.trim().isEmpty
                    ? "Mời bạn nhập email"
                    : !_validator.isEmailValid(input)
                        ? "Email không hợp lệ"
                        : null,
                onSaved: (input) => _email = input!.trim(),
                decoration:
                    _buildDecoration("Email của bạn", Icons.email, false),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
                keyboardType: TextInputType.text,
                maxLength: 20,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                validator: (input) => input!.isEmpty || input.length < 8
                    ? "Mật khẩu phải chứa 8 đến 20 ký tự"
                    : !_validator.isPasswordValid(input)
                        ? "Mật khẩu chứa ít nhất 1 chữ hoa, 1 chữ thường và 1 chữ số"
                        : null,
                onSaved: (input) => _password = input!,
                obscureText: _hidePassword,
                decoration: _buildDecoration("Mật khẩu", Icons.lock, true),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                onPressed: () {
                  _verifyInfoAndGenerateOtp();
                },
                style: ElevatedButton.styleFrom(fixedSize: const Size(330, 50)),
                child: const Text(
                  "Tiếp tục",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ));
  }

  InputDecoration _buildDecoration(
      String hintText, IconData prefixIcon, bool forPasswordField) {
    return InputDecoration(
        hintText: hintText,
        counterText: "",
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.2))),
        focusedBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.secondary)),
        prefixIcon: Icon(
          prefixIcon,
          color: Theme.of(context).colorScheme.secondary,
        ),
        suffixIcon: forPasswordField
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _hidePassword = !_hidePassword;
                  });
                },
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
                icon: Icon(
                    _hidePassword ? Icons.visibility_off : Icons.visibility),
              )
            : null);
  }

  bool _validateAndSave() {
    final form = _globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _verifyInfoAndGenerateOtp() {
    if (_validateAndSave()) {
      UserService userService = const UserService();
      VerifyInfoRequest request = VerifyInfoRequest(name: _name, email: _email);
      userService.verifyInfoAndGenerateOtp(request).then((value) => {
            if (value is Exception)
              {_toastBuilder.build(value.message)}
            else
              {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InputOtp(
                            name: _name, email: _email, password: _password)))
              }
          });
    }
  }
}

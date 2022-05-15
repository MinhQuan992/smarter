import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smarter/models/authentication/authentication_request.dart';
import 'package:smarter/screens/dashboard/dashboard.dart';
import 'package:smarter/services/authentication_service.dart';
import 'package:smarter/utils/toast_builder.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool _hidePassword = true;
  final GlobalKey<FormState> _globalFormKey = GlobalKey<FormState>();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final ToastBuilder _toastBuilder = const ToastBuilder();

  late String _email, _password;

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
            child: Icon(
              Icons.book_sharp,
              size: 100,
              color: Colors.blueAccent,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                "Đăng nhập",
                style: TextStyle(color: Colors.black, fontSize: 30),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                "Chào mừng bạn trở lại với Smarter!",
                style: TextStyle(color: Colors.grey, fontSize: 18),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              validator: (input) => input!.isEmpty || input.trim().isEmpty
                  ? "Mời bạn nhập email"
                  : null,
              onSaved: (input) => _email = input!.trim(),
              decoration: _buildDecoration("Email của bạn", Icons.email, false),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: TextFormField(
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
              keyboardType: TextInputType.text,
              validator: (input) =>
                  input!.isEmpty ? "Mời bạn nhập mật khẩu" : null,
              onSaved: (input) => _password = input!,
              obscureText: _hidePassword,
              decoration: _buildDecoration("Mật khẩu", Icons.lock, true),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: ElevatedButton(
              onPressed: () {
                _authenticate();
              },
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  fixedSize:
                      MaterialStateProperty.all<Size>(const Size(330, 50))),
              child: const Text(
                "Đăng nhập",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
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

  void _authenticate() {
    if (_validateAndSave()) {
      AuthenticationService authenticationService =
          const AuthenticationService();
      AuthenticationRequest authenticationRequest =
          AuthenticationRequest(email: _email, password: _password);
      authenticationService
          .authenticate(authenticationRequest)
          .then((value) async => {
                if (value.token != "")
                  {
                    await _storage.write(key: "token", value: value.token),
                    debugPrint(value.token),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DashBoard()))
                  }
                else
                  {_toastBuilder.build("Email hoặc mật khẩu sai")}
              });
    }
  }
}

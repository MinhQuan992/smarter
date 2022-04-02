import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smarter/models/authentication/authentication_request.dart';
import 'package:smarter/screens/dashboard/dashboard.dart';
import 'package:smarter/services/authentication_service.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  FlutterSecureStorage storage = const FlutterSecureStorage();

  late String _email, _password;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: globalFormKey,
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
              validator: (input) =>
                  input == null || input.isEmpty ? "Mời bạn nhập email!" : null,
              onSaved: (input) => _email = input!,
              decoration: InputDecoration(
                hintText: "Email của bạn",
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.2))),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary)),
                prefixIcon: Icon(
                  Icons.email,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: TextFormField(
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
              keyboardType: TextInputType.text,
              validator: (input) => input == null || input.isEmpty
                  ? "Mời bạn nhập mật khẩu!"
                  : null,
              onSaved: (input) => _password = input!,
              obscureText: hidePassword,
              decoration: InputDecoration(
                hintText: "Mật khẩu",
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.2))),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary)),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.4),
                  icon: Icon(
                      hidePassword ? Icons.visibility_off : Icons.visibility),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: ElevatedButton(
              onPressed: () {
                _authenticate();
              },
              style: ElevatedButton.styleFrom(fixedSize: const Size(330, 50)),
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

  bool _validateAndSave() {
    final form = globalFormKey.currentState;
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
                    await storage.write(key: "token", value: value.token),
                    debugPrint(value.token),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DashBoard()))
                  }
                else
                  {
                    Fluttertoast.showToast(
                        msg: "Email hoặc mật khẩu sai. Mời bạn thử lại!",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black87,
                        textColor: Colors.white,
                        fontSize: 13.0)
                  }
              });
    }
  }
}

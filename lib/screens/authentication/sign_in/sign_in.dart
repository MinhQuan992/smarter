import 'package:flutter/material.dart';
import 'package:smarter/screens/authentication/sign_in/sign_in_form.dart';
import 'package:smarter/screens/authentication/sign_up/sign_up.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Column(
                children: <Widget>[
                  const SignInForm(),
                  Row(
                    children: <Widget>[
                      const Text(
                        "Quên mật khẩu?",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(133, 0, 0, 0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignUp()));
                            },
                            child: const Text(
                              "Đăng ký",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ))
                    ],
                  )
                ],
              )),
        ));
  }
}

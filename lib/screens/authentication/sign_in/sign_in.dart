import 'package:flutter/material.dart';
import 'package:smarter/screens/authentication/sign_in/sign_in_form.dart';
import 'package:smarter/screens/authentication/sign_up/sign_up.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

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
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          "Quên mật khẩu?",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUp()));
                        },
                        child: Text(
                          "Đăng ký",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              )),
        ));
  }
}

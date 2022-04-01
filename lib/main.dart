import 'package:flutter/material.dart';
import 'package:smarter/screens/authentication/sign_in/sign_in.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smarter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignIn(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:smarter/screens/dashboard/dashboard.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

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
                  !input!.contains('@') ? "Email không hợp lệ!" : null,
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
              validator: (input) => input!.length < 8
                  ? "Mật khẩu phải chứa ít nhất 8 ký tự"
                  : null,
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const DashBoard()));
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
}

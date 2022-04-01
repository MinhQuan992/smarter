import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool hidePassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
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
            decoration: InputDecoration(
              hintText: "Tên của bạn",
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
                Icons.person,
                color: Theme.of(context).colorScheme.secondary,
              ),
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
            validator: (input) =>
                input!.length < 8 ? "Mật khẩu phải chứa ít nhất 8 ký tự" : null,
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
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
                icon: Icon(
                    hidePassword ? Icons.visibility_off : Icons.visibility),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: ElevatedButton(
            onPressed: () {},
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
}

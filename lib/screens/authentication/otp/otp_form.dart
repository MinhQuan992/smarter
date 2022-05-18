import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smarter/models/exception.dart';
import 'package:smarter/models/user/add_user_request.dart';
import 'package:smarter/screens/authentication/sign_in/sign_in.dart';
import 'package:smarter/services/user_service.dart';
import 'package:smarter/utils/toast_builder.dart';

class OtpForm extends StatefulWidget {
  final String name;
  final String email;
  final String password;
  const OtpForm(
      {required this.name,
      required this.email,
      required this.password,
      Key? key})
      : super(key: key);

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  final ToastBuilder _toastBuilder = const ToastBuilder();
  final GlobalKey<FormState> _globalFormKey = GlobalKey<FormState>();
  final FocusNode pin1FocusNode = FocusNode();
  final FocusNode pin2FocusNode = FocusNode();
  final FocusNode pin3FocusNode = FocusNode();
  final FocusNode pin4FocusNode = FocusNode();
  final FocusNode pin5FocusNode = FocusNode();
  final FocusNode pin6FocusNode = FocusNode();

  late String _num1, _num2, _num3, _num4, _num5, _num6;

  @override
  void dispose() {
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    pin5FocusNode.dispose();
    pin6FocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const inputDecoration = InputDecoration(
      counterText: "",
      enabledBorder: UnderlineInputBorder(),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
    );

    return Form(
        key: _globalFormKey,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 50,
                  child: TextFormField(
                    style: const TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    focusNode: pin1FocusNode,
                    autofocus: true,
                    decoration: inputDecoration,
                    onSaved: (input) => _num1 = input!,
                    onChanged: (input) {
                      _changePin(input, null, pin1FocusNode, pin2FocusNode);
                    },
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: TextFormField(
                    style: const TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    focusNode: pin2FocusNode,
                    decoration: inputDecoration,
                    onSaved: (input) => _num2 = input!,
                    onChanged: (input) {
                      _changePin(
                          input, pin1FocusNode, pin2FocusNode, pin3FocusNode);
                    },
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: TextFormField(
                    style: const TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    focusNode: pin3FocusNode,
                    decoration: inputDecoration,
                    onSaved: (input) => _num3 = input!,
                    onChanged: (input) {
                      _changePin(
                          input, pin2FocusNode, pin3FocusNode, pin4FocusNode);
                    },
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: TextFormField(
                    style: const TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    focusNode: pin4FocusNode,
                    decoration: inputDecoration,
                    onSaved: (input) => _num4 = input!,
                    onChanged: (input) {
                      _changePin(
                          input, pin3FocusNode, pin4FocusNode, pin5FocusNode);
                    },
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: TextFormField(
                    style: const TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    focusNode: pin5FocusNode,
                    decoration: inputDecoration,
                    onSaved: (input) => _num5 = input!,
                    onChanged: (input) {
                      _changePin(
                          input, pin4FocusNode, pin5FocusNode, pin6FocusNode);
                    },
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: TextFormField(
                    style: const TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    focusNode: pin6FocusNode,
                    decoration: inputDecoration,
                    onSaved: (input) => _num6 = input!,
                    onChanged: (input) {
                      _changePin(input, pin5FocusNode, pin6FocusNode, null);
                    },
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 100, 0, 30),
              child: ElevatedButton(
                onPressed: () {
                  _addUser();
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                    fixedSize:
                        MaterialStateProperty.all<Size>(const Size(330, 50))),
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

  void _changePin(String value, FocusNode? previousNode, FocusNode currentNode,
      FocusNode? nextNode) {
    if (value.length == 1) {
      nextNode != null ? nextNode.requestFocus() : currentNode.unfocus();
    } else if (value.isEmpty) {
      previousNode != null
          ? previousNode.requestFocus()
          : currentNode.unfocus();
    }
  }

  bool _validateAndSave() {
    final form = _globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _addUser() {
    if (_validateAndSave()) {
      String otp = _num1 + _num2 + _num3 + _num4 + _num5 + _num6;
      if (otp.length != 6) {
        _toastBuilder.build("Bạn phải nhập đầy đủ mã OTP");
      } else {
        UserService userService = const UserService();
        AddUserRequest request = AddUserRequest(
            name: widget.name,
            email: widget.email,
            password: widget.password,
            otp: otp);
        userService.addUser(request).then((value) => {
              if (value is Exception)
                {_toastBuilder.build(value.message)}
              else
                {
                  _toastBuilder.build(
                      "Đăng ký tài khoản thành công. Mời bạn đăng nhập để tiếp tục!"),
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SignIn()))
                }
            });
      }
    }
  }
}

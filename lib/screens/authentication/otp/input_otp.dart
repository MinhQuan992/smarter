import 'package:flutter/material.dart';
import 'package:smarter/models/exception.dart';
import 'package:smarter/models/user/verify_info_request.dart';
import 'package:smarter/screens/authentication/otp/otp_form.dart';
import 'package:smarter/services/user_service.dart';
import 'package:smarter/utils/toast_builder.dart';

class InputOtp extends StatefulWidget {
  final String name;
  final String email;
  final String password;

  const InputOtp(
      {required this.name,
      required this.email,
      required this.password,
      Key? key})
      : super(key: key);

  @override
  State<InputOtp> createState() => _InputOtpState();
}

class _InputOtpState extends State<InputOtp> {
  int _numberOfResendOtpAttempts = 0;
  final ToastBuilder _toastBuilder = const ToastBuilder();

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
        margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const Text("Xác thực mã OTP",
                  style: TextStyle(color: Colors.black, fontSize: 30)),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(
                  "Hệ thống đã gửi mã OTP đến email của bạn.",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
              _buildTimer(),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                  child: OtpForm(
                      name: widget.name,
                      email: widget.email,
                      password: widget.password)),
              GestureDetector(
                onTap: () {
                  _resendOtp();
                },
                child: const Text(
                  "Gửi lại mã OTP",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

  Row _buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Mã OTP này sẽ hết hạn trong ",
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 120, end: 0),
          duration: const Duration(seconds: 120),
          onEnd: () {
            _toastBuilder.build("Mã OTP đã hết hạn. Mời bạn lấy mã khác!");
          },
          builder: (BuildContext context, double value, Widget? child) {
            int minute = value.round() ~/ 60;
            int second = value.round() % 60;
            return Text(
              second < 10 ? "0$minute:0$second" : "0$minute:$second",
              style: const TextStyle(color: Colors.blue),
            );
          },
        )
      ],
    );
  }

  void _resendOtp() {
    UserService userService = const UserService();
    VerifyInfoRequest request =
        VerifyInfoRequest(name: widget.name, email: widget.email);
    userService.verifyInfoAndGenerateOtp(request).then((value) => {
          if (value is Exception)
            {_toastBuilder.build(value.message)}
          else
            {
              _toastBuilder.build("Mã OTP mới đã được gửi về email của bạn"),
              setState(() {
                //TODO: check the reason why Flutter cannot redraw widgets
                _numberOfResendOtpAttempts = _numberOfResendOtpAttempts + 1;
              })
            }
        });
  }
}

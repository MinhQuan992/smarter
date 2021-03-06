import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastBuilder {
  const ToastBuilder();

  void build(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 13.0);
  }
}

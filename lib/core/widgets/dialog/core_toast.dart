import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart' as prefix0;

class Toast {
  ///[msg] Nội dung sẽ hiển thị
  ///[msgColor] Màu của nội dung sẽ hiển thị
  ///[bgColor] Màu nền sẽ hiển thị
  ///[fontSize] Kích thước font chữ nội dung
  ///[position] Vị trí sẽ hiển thị [Position]
  static void showLongTop(
    String msg, {
    int msgColor = 0xFFffffff,
    int bgColor = 0xFF005a88,
    double fontSize = 16.0,
  }) {
    if (msg.trim().toString() == '') {
      return;
    }
    prefix0.Fluttertoast.showToast(
      msg: msg,
      fontSize: fontSize,
      toastLength: prefix0.Toast.LENGTH_SHORT,
      gravity: prefix0.ToastGravity.TOP,
      backgroundColor: Color(bgColor),
      textColor: Color(msgColor),
      timeInSecForIosWeb: 5,
    );
  }
}

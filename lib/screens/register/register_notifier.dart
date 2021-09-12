import 'dart:convert';

import 'package:capcha/core/public/global.dart';
import 'package:capcha/core/public/global.dart';
import 'package:capcha/core/ulitis/utils.dart';
import 'package:capcha/core/widgets/dialog/dialog_alert.dart';
import 'package:capcha/models/captcha_model.dart';
import 'package:capcha/screens/application/application_service.dart';
import 'package:capcha/screens/register/register_service.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

class RegisterNotifier extends ChangeNotifier {
  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController phoneNumberCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController captchaCtrl = TextEditingController();

  CaptchaModel? captchaModel;
  RegisterNotifier(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      getCaptCha(context);
    });
  }
  Future<void> getCaptCha(BuildContext context) async {
    captchaModel = await applicationService.getCaptcha(context);
    notifyListeners();
  }

  Future<void> onRegister(BuildContext context) async {
    FocusScope.of(context).unfocus();
    usernameCtrl.text = usernameCtrl.text.trim();
    phoneNumberCtrl.text = phoneNumberCtrl.text.trim();
    passwordCtrl.text = passwordCtrl.text.trim();
    captchaCtrl.text = captchaCtrl.text.trim();
    if (usernameCtrl.text.isEmpty) {
      DialogAlert.showNotification(
          context, "Thông báo", "Vui lòng nhập tên đăng nhập");
      return;
    }
    if (usernameCtrl.text.length < 5 && usernameCtrl.text.length < 13) {
      DialogAlert.showNotification(context, "Thông báo",
          "Vui lòng nhập tên đăng nhập từ 5 đến 13 kí tự");
      return;
    }
    if (phoneNumberCtrl.text.isEmpty) {
      DialogAlert.showNotification(
          context, "Thông báo", "Vui lòng nhập số điện thoại");
      return;
    }
    if (passwordCtrl.text.isEmpty) {
      DialogAlert.showNotification(
          context, "Thông báo", "Vui lòng nhập mật khẩu");
      return;
    }

    if (passwordCtrl.text.length < 8) {
      DialogAlert.showNotification(
          context, "Thông báo", "Vui lòng nhập mật khẩu dài hơn 8 kí tự");
      return;
    }
    String password = passwordCtrl.text;
    // if (password.length >= 10 &&
    //     !password.contains(RegExp(r'\W')) &&
    //     RegExp(r'\d+\w*\d+').hasMatch(password)) {
    //   print(" \n\t$password hợp lệ");
    // } else {
    //   print("\n\t$password không hợp lệ");
    // }

    if (password.length < 8 && !password.contains(new RegExp(r'[A-Z]'))) {
      print(" \n\t$password hợp lệ");
    } else {
      print("\n\t$password không hợp lệ");
    }

    // bool isPasswordCompliant(String password, [int minLength = 6]) {
    //   if (password == null || password.isEmpty) {
    //     DialogAlert.showNotification(
    //         context, "Thông báo", "Vui lòng nhập mật khẩu dài hơn 6 kí tự");
    //   }

    // bool hasUppercase(String password) {
    //   if (password.length < 8 && !password.contains(new RegExp(r'[A-Z]'))) {
    //     DialogAlert.showNotification(
    //         context, "Thông báo", "Vui lòng nhập mật khẩu dài hơn 8 kí tự");
    //   }
    //   return hasUppercase(password);

    //   // bool hasDigits = password.contains(new RegExp(r'[0-9]'));
    //   // bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
    //   // bool hasSpecialCharacters = password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    //   // bool hasMinLength = password.length > minLength;

    //   // return hasDigits & hasUppercase & hasLowercase & hasSpecialCharacters & hasMinLength;
    // }

    if (captchaCtrl.text.isEmpty) {
      DialogAlert.showNotification(
          context, "Thông báo", "Vui lòng nhập mã captcha");
      return;
    }
    String phone = phoneNumberCtrl.text;
    if (phoneNumberCtrl.text[0] == '0') {
      phoneNumberCtrl.text = phoneNumberCtrl.text.replaceFirst("0", "84 ");
    }
    int length;
    if (phone.length < 10) {
      DialogAlert.showNotification(
          context, "Thông báo", "Vui lòng nhập đúng số điện thoại");
      return;
    }
    Map<String, dynamic> body = {
      "playerid": usernameCtrl.text,
      "password": Hmac(sha1, utf8.encode(usernameCtrl.text))
          .convert(utf8.encode(passwordCtrl.text)),
      // "mobile":phoneNumberCtrl.text,
      "mobile": phone,
      "currency": "VND2",
      "language": 4,
      "captcha": captchaCtrl.text,
      "captchauuid": captchaModel!.uuid
    };

    dynamic result = await registerService.register(context, body);
    if (result != null) {
      Global.token = result['token'];
      DialogAlert.showNotification(context, "Thông báo", "Đăng ký thành công",
          onClickOk: () {
        Navigator.pop(context);
      });
    }

    print(body);
  }
}

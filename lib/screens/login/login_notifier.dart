import 'dart:convert';

import 'package:capcha/core/public/global.dart';
import 'package:capcha/core/widgets/dialog/dialog_alert.dart';
import 'package:capcha/models/captcha_model.dart';
import 'package:capcha/screens/application/application_service.dart';
import 'package:capcha/screens/home/home_screen.dart';
import 'package:capcha/screens/login/login_service.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

class LoginNotifier extends ChangeNotifier {
  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController captchaCtrl = TextEditingController();

  CaptchaModel? captchaModel;
  LoginNotifier(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      getCaptCha(context);
    });
  }
  Future<void> getCaptCha(BuildContext context) async {
    captchaModel = await applicationService.getCaptcha(context);
    notifyListeners();
  }

  Future<void> onLogin(BuildContext context) async {
    FocusScope.of(context).unfocus();
    usernameCtrl.text = usernameCtrl.text.trim();
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
    if (passwordCtrl.text.isEmpty) {
      DialogAlert.showNotification(
          context, "Thông báo", "Vui lòng nhập mật khẩu");
      return;
    }
    String password = passwordCtrl.text;
    // bool validateStructure;( String password = password){
    //   Pattern pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    //   RegExp regex = new RegExp(pattern);
    //   print()

    // }

    if (passwordCtrl.text.length > 8 &&
        !password.contains(RegExp(r'\W')) &&
        RegExp(r'\d+\w*\d+').hasMatch(password)) {
      DialogAlert.showNotification(
          context, "Thông báo", "Mật khẩu nhập đúng định dạng");
      return;
    }
    // else {
    //   DialogAlert.showNotification(context, "Thông báo",
    //       "Vui lòng nhập mật khẩu dài hơn 8 kí tự, bao gồm chữ và số");
    //   return;
    // }
    if (captchaCtrl.text.isEmpty) {
      DialogAlert.showNotification(
          context, "Thông báo", "Vui lòng nhập mã captcha");
      return;
    }

    Map<String, dynamic> body = {
      "loginname": usernameCtrl.text,
      "loginpassword": Hmac(sha1, utf8.encode(usernameCtrl.text))
          .convert(utf8.encode(passwordCtrl.text))
          .toString(),
      "captcha": captchaCtrl.text,
      "captchauuid": captchaModel!.uuid,
      "fingerprint": "",
      "portalid": ""
    };

    dynamic result = await loginService.login(context, body);
    if (result != null) {
      Global.token = result['token'];
      Navigator.pushNamedAndRemoveUntil(
          context, HomeScreen.routeName, (route) => false);
    } else {
      getCaptCha(context);
    }
  }
}

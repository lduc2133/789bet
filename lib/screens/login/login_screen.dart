import 'dart:convert';

import 'package:capcha/core/constants/name_icon.dart';
import 'package:capcha/core/public/translate.dart';
import 'package:capcha/core/widgets/button/button_change_languge_widget.dart';
import 'package:capcha/core/widgets/image/local_image_widget.dart';
import 'package:capcha/screens/login/login_notifier.dart';
import 'package:capcha/screens/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/Login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginNotifier presenter;

  @override
  Widget build(BuildContext context) {
    presenter = Provider.of<LoginNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng nhập'),
      ),
      body: Container(
        padding: EdgeInsets.all(24),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 32,
              ),
              LocalImageWidget(
                url: png_language_vn,
                width: MediaQuery.of(context).size.width * .5,
                boxFit: BoxFit.fitHeight,
                height: 160,
              ),
              SizedBox(
                height: 32,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).primaryColorDark,
                    ),
                    borderRadius: BorderRadius.circular(16)),
                child: TextField(
                  controller: presenter.usernameCtrl,
                  decoration: new InputDecoration(
                    hintText: "Tên tài khoản",
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).primaryColorDark,
                    ),
                    borderRadius: BorderRadius.circular(16)),
                child: TextField(
                  controller: presenter.passwordCtrl,
                  obscureText: true,
                  decoration: new InputDecoration(
                    hintText: "Mật khẩu",
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).primaryColorDark,
                          ),
                          borderRadius: BorderRadius.circular(16)),
                      child: TextField(
                        controller: presenter.captchaCtrl,
                        keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                          hintText: "Mã captcha",
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  presenter.captchaModel == null
                      ? Container()
                      : SizedBox(
                          width: 8,
                        ),
                  presenter.captchaModel == null
                      ? Container()
                      : Image.memory(base64Decode(presenter.captchaModel!.image
                          .replaceAll("data:image/jpeg;base64,", ""))),
                  presenter.captchaModel == null
                      ? Container()
                      : IconButton(
                          onPressed: () {
                            presenter.getCaptCha(context);
                          },
                          icon: Icon(Icons.wifi_protected_setup_outlined)),
                ],
              ),
              SizedBox(
                height: 48,
              ),
              Container(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    presenter.onLogin(context);
                  },
                  child: Text(
                    "Đăng nhập",
                    style: TextStyle(fontSize: 17),
                  ),
                  style: ElevatedButton.styleFrom(
                    // primary: Theme.of(context).primaryColorDark,
                    primary: Colors.deepOrange,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Bạn chưa có tài khoản"),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RegisterScreen.routeName);
                      },
                      child: Text("Đăng ký"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

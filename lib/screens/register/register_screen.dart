import 'dart:convert';

import 'package:capcha/core/constants/name_icon.dart';
import 'package:capcha/core/public/translate.dart';
import 'package:capcha/core/widgets/button/button_change_languge_widget.dart';
import 'package:capcha/core/widgets/image/local_image_widget.dart';
import 'package:capcha/screens/login/login_notifier.dart';
import 'package:capcha/screens/register/register_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
// import 'package:form_validator/form_validator.dart';
// import 'package:validators/validators.dart';

// import 'package:form_validator/form_validator.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/Register';

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late RegisterNotifier presenter;
  // String validateName(String value) {
  //   if (value.length < 3)
  //     return 'Name must be more than 2 charater';
  //   else
  //     return 'Tiếp tục nhập mật khẩu';
  // }
  final _formKey = GlobalKey<FormState>();
  // variable to enable auto validating of theform
  bool _autoValidate = true;
  // variable to enable toggling between showing and hiding password
  bool _hidePassword = true;
  // bool _autoValidate = false;

  String validatePassword(String value) {
    if (value.isEmpty) {
      return "* Required";
    } else if (value.length < 6) {
      return "Password should be atleast 6 characters";
    } else if (value.length > 15) {
      return "Password should not be greater than 15 characters";
    } else
      return "true";
  }

  @override
  Widget build(BuildContext context) {
    presenter = Provider.of<RegisterNotifier>(context);
    final maxLines = 5;
    return Scaffold(
      appBar: AppBar(
        title: Text("Đăng ký"),
      ),
      body: Container(
        padding: EdgeInsets.all(24),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                  child: TextFormField(
                    controller: presenter.usernameCtrl,
                    decoration: new InputDecoration(
                      hintText: "Tên đăng nhập",
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    keyboardType: TextInputType.text,
                    validator: (String? value) {
                      // confirmPass = value;
                      if (value!.isEmpty) {
                        return "Tên đăng nhập không được để trống";
                      } else if (value.length < 5) {
                        return "Tên đăng nhập phải nhiều hơn 5 kí tự";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 24,
                ),

                Container(
                  // height: 12,
                  // margin: EdgeInsets.all(12),
                  height: maxLines * 12.0,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColorDark,
                      ),
                      borderRadius: BorderRadius.circular(16)),
                  child: TextFormField(
                    textAlign: TextAlign.left,
                    maxLines: maxLines,
                    maxLength: 10,
                    controller: presenter.phoneNumberCtrl,
                    keyboardType: TextInputType.phone,
                    decoration: new InputDecoration(
                      contentPadding: EdgeInsets.all(-2.0),
                      hintText: "Số điện thoại",
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    // cursorHeight: 20,
                    // validator: validateMobile,
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
                  child: TextFormField(
                    // maxLength: 12,
                    // final validate = ValidationBuilder().minLength(8).maxLength(15).build();
                    obscureText: true,
                    controller: presenter.passwordCtrl,
                    decoration: new InputDecoration(
                      hintText: "Mật khẩu",
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),

                    validator: (String? value) {
                      // confirmPass = value;
                      if (value!.isEmpty) {
                        return "Hãy nhật mật khẩu của bạn";
                      } else if (value.length < 8) {
                        return "Mật khẩu phải nhiều hơn 8 kí tự";
                      } else {
                        return null;
                      }
                    },
                    // validator: Validators.compose([
                    //   Validators.required('Password is required'),
                    //   Validators.patternString(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$', 'Invalid Password')
                    // ]),
                    // validator: FormBuilderValidators.compose([
                    //     FormBuilderValidators.required(context,
                    //         errorText: 'Hãy nhập mật khẩu của bạn'),
                    //     FormBuilderValidators.minLength(context, 8,
                    //         errorText: 'Mật khẩu tối thiểu 8 kí tự'),
                    //   ]),
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
                        : Image.memory(base64Decode(presenter
                            .captchaModel!.image
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
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       "Lưu ý: Tên đăng nhập có độ dài từ 5 đến 13 ký tự. Nhập đúng số điện thoại, bắt đầu bằng số 0. Mật khẩu nhiều hơn 8 kí tự (bao gồm chữ và số). ",
                //       // overflow: TextOverflow.ellipsis,
                //     ),
                //     // TextButton(
                //     //     onPressed: () {
                //     //       Navigator.pop(context);
                //     //     },
                //     //     child: Text("Đăng nhập"))
                //   ],
                // ),
                SizedBox(
                  height: 48,
                ),
                Container(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      presenter.onRegister(context);
                    },
                    child: Text(
                      "Đăng ký",
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
                    Text("Bạn đã có tài khoản"),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Đăng nhập"))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{11}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return 'true';
  }
}

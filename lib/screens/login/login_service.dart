
import 'package:capcha/core/base_service/api_dio.dart';
import 'package:capcha/core/constants/url_static.dart';
import 'package:capcha/core/public/global.dart';
import 'package:capcha/screens/login/login_interface.dart';
import 'package:flutter/material.dart';
LoginService loginService = LoginService();
class LoginService implements ILoginInterface {
  @override
  Future login(BuildContext context, Map<String, dynamic> body) async {
    try {
      final res = await ApiDio.getInstance()!.createPost(
          Global.baseUrl + UrlStatic.API_LOGIN,
          context: context,
          body: body,
          showLoading: true);
      return res;
    } catch (e) {
      return null;
    }
  }

}

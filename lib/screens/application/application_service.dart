import 'package:capcha/core/base_service/api_dio.dart';
import 'package:capcha/core/constants/url_static.dart';
import 'package:capcha/core/public/global.dart';
import 'package:capcha/models/captcha_model.dart';
import 'package:capcha/screens/login/login_screen.dart';
import 'package:flutter/material.dart';

import 'application_interface.dart';

ApplicationService applicationService = ApplicationService();

class ApplicationService implements IApplicationInterface {
  @override
  Future<CaptchaModel?> getCaptcha(BuildContext context) async {
    CaptchaModel result;
    try {
      final res = await ApiDio.getInstance()!.createPost(
          Global.baseUrl + UrlStatic.API_GET_CAPTCHA,
          context: context,
          showLoading: false);
      result = CaptchaModel.fromMap(res);
    } catch (e) {
      return null;
    }
    return result;
  }

  @override
  Future checkApp(BuildContext context) async {
    final res = await ApiDio.getInstance()!.createPost(
        "http://162.243.168.88/web/login",
        body: {
          "username":"admin",
          "password":"123456789a"
        },
        context: context,
        showLoading: false);
    if(res['message']=='Đăng nhập thành công'){

    }
  }
}

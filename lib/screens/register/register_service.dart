import 'package:capcha/core/base_service/api_dio.dart';
import 'package:capcha/core/constants/url_static.dart';
import 'package:capcha/core/public/global.dart';
import 'package:capcha/screens/login/login_interface.dart';
import 'package:capcha/screens/register/register_interface.dart';
import 'package:flutter/material.dart';

RegisterService registerService = RegisterService();

class RegisterService implements IRegisterInterface {
  @override
  Future register(BuildContext context, Map<String, dynamic> body) async {
    try {
      final res = await ApiDio.getInstance()!.createPostFile(
          Global.baseUrl + UrlStatic.API_REGISTER, context,
          showLoading: true,body: body,listFile: [],keyFileUpload: '');
      return res;
    } catch (e) {
      return null;
    }
  }
}

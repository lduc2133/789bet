import 'dart:convert';
import 'package:capcha/core/data_local/share_prefer_utils.dart';
import 'package:capcha/core/public/global.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

import 'base_service.dart';

class ApiDio {
  ApiDio() {
    final BaseOptions options = BaseOptions(
      baseUrl: Global.baseUrl,
      connectTimeout: Global.timeOutApi,
      receiveTimeout: Global.timeOutApi,
    );
    final Dio dio = Dio(options);
    dio.interceptors.add(AuthInterceptor());

    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      requestBody: true,
    ));
    baseService = BaseServices(dio);
  }

  static ApiDio? instance;
  static BaseServices? baseService;



  static BaseServices? getInstance() {
    instance ??= ApiDio();
    return _getBaseService();
  }

  static BaseServices? _getBaseService() {
    return baseService;
  }


 static  Future<dynamic> loadAsset(String linkFile) async {
    return jsonDecode(await rootBundle.loadString(linkFile));
  }
}

class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(RequestOptions options,RequestInterceptorHandler handler) async {
    final Map<String, String> headers =  {
      'content-type':'application/json'
    };
    // headers['accept-language'] = Global.language;
    // await SharePreferUtils.getUserInformation().then((userInformation) => {
    //   if(userInformation!=null){
    //     headers['Authorization'] =
    //     'Bearer ${userInformation.token}'
    //   }
    // });

    options.headers = headers;
    return super.onRequest(options,handler);
  }

}

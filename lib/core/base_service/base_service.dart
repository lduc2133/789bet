import 'dart:io';

import 'package:capcha/core/public/translate.dart';
import 'package:capcha/core/widgets/dialog/core_toast.dart';
import 'package:capcha/core/widgets/dialog/dialog_alert.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class BaseServices {
  BaseServices(this.dio);

  Dio dio;

  Future<dynamic> createPost(
    String subUri, {
    bool showLoading = false,
    dynamic body,
    required BuildContext context,
  }) async {
// convert  body
    if (body.runtimeType == String) {
      body = body;
    }

    /// Check xem có mạng không
    final ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    switch (connectivityResult) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        break;
      case ConnectivityResult.none:
        errorApiCallback(
          response: Response<dynamic>(
            statusMessage: Translate.text('network'),
            requestOptions: RequestOptions(path: subUri),
          ),
        );
        return;
    }

    if (showLoading == true) {
      DialogAlert.showLoading(context);
    }

    try {
      final Response<dynamic> response =
          await dio.post<dynamic>(subUri, data: body ?? {});
      if (showLoading == true) {
        Navigator.pop(context);
      }
      if (response.statusCode != null) {
        return response.data;
      }
    } on DioError catch (onError) {
      print('onError catch + ${onError.type.index}');
      if (showLoading) {
        Navigator.pop(context);
      }
      getError(context,onError);
      return;

      switch (onError.type.index) {
        case 0:
          errorApiCallback(
            response: onError.response!,
          );
          break;
        case 5:
          errorApiCallback(
            response: onError.response!,
          );
          break;
        default:
          errorApiCallback(
            response: onError.response!,
          );
          break;
      }
    }
  }

  Future<dynamic> createPostFile(
      String subUri,
      BuildContext context, {
        bool showLoading = false,
        dynamic body,
        List<File>? listFile,
        String? keyFileUpload,
        // ignore: avoid_positional_boolean_parameters
      }) async {
    /// Check xem có mạng không
    var connectivityResult = await (Connectivity().checkConnectivity());
    switch (connectivityResult) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        break;
      case ConnectivityResult.none:
        errorApiCallback(
          response: Response<dynamic>(
            statusMessage: Translate.text('network'),
            requestOptions: RequestOptions(path: subUri),
          ),
        );
        return;
    }

    if (showLoading) {
      DialogAlert.showLoading(context);
    }
    try {
      FormData formData = FormData.fromMap(body);
      for (File item in listFile!)
        formData.files.addAll([
          MapEntry(keyFileUpload!, await MultipartFile.fromFile(item.path)),
        ]);
      final Response<dynamic> response = await dio.post(subUri, data: formData);
      if (showLoading) {
        // Navigator.of(context).pop(true);
        Navigator.pop(context);
      }
      if (response.statusCode != null) {
        return response.data;
      }

    } on DioError catch (onError) {
      print('onError catch + ${onError.type.index}');
      if (showLoading) {
        Navigator.pop(context);
      }
      getError(context,onError);
      return ;
      switch (onError.type.index) {
        case 0:
          errorApiCallback(
            response: onError.response!,
          );
          break;
        case 5:
          errorApiCallback(
            response: onError.response!,
          );
          break;
        default:
          errorApiCallback(
            response: onError.response!,
          );
          break;
      }
    }
  }
}

void getError(BuildContext context,DioError onError){
  if(onError.response!.statusCode==498){
    switch(onError.response!.data['code']){
      case 1:
        DialogAlert.showNotification(context, "Thông báo", "Captcha không hợp lệ");
        return;
      case 2:
        if(onError.requestOptions.uri.path=="/789bet-ecp/api/v1/register"){
          DialogAlert.showNotification(context, "Thông báo", "Tài khoản đã được đăng ký");
        }else{
          DialogAlert.showNotification(context, "Thông báo", "Tài khoản hoặc mật khẩu không chính xác ");
        }
        return;
      case 3:
        DialogAlert.showNotification(context, "Thông báo", "Email đã được đăng ký ");
        return;
      case 4:
        DialogAlert.showNotification(context, "Thông báo", "Số điện thoại đã được đăng ký ");
        return;
      case 5:
        DialogAlert.showNotification(context, "Thông báo", "Id đơn vị liên kết được liên kết với bất kỳ người chơi đã đăng ký nào ");
        return;
      case 6:
        DialogAlert.showNotification(context, "Thông báo", "OTP đã gửi không thành công ");
        return;
      case 7:
        DialogAlert.showNotification(context, "Thông báo", "Họ và tên đã được đăng ký ");
        return;
      case 8:
        DialogAlert.showNotification(context, "Thông báo", "Hình ảnh nhận dạng hoặc thẻ ngân hàng không đúng");
        return;
      case 9:
        DialogAlert.showNotification(context, "Thông báo", "Khu vực cụ thể đã được đăng ký ");
        return;
      case 10:
        DialogAlert.showNotification(context, "Thông báo", "Trạng thái liên kết không hoạt động ");
        return;
      case 11:
        DialogAlert.showNotification(context, "Thông báo", "Đơn vị tiền tệ của đơn vị liên kết không ngang bằng với đơn vị tiền tệ của người chơi ");
        return;
      case 16:
        DialogAlert.showNotification(context, "Thông báo", "Sai định dạng số điện thoại");
        return;
      default:
        DialogAlert.showNotification(context, "Thông báo", onError.response!.data['msg']);
        return;
    }

  }
}

void errorApiCallback({
  required Response<dynamic> response,
}) {
  Toast.showLongTop(response.statusMessage!);
}

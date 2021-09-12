import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:capcha/core/constants/name_icon.dart';
import 'package:capcha/core/public/translate.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

typedef ValueOtp<String> = String Function(String);

class DialogAlert {
  static void showLoading(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return SimpleDialog(children: <Widget>[
            Center(
              child: Column(
                children: [
                  Lottie.asset(
                      json_loading,
                     height: 80
                      ),
                  Text(Translate.text("loading"))
                ],
              ),
            )
          ]);
        });
  }

  static void dismissLoading(BuildContext context, {int? time}) {
    if (time != null) {
      Future.delayed(Duration(seconds: time), () {
        Navigator.of(context).pop();
      });
    } else {
      Navigator.of(context).pop();
    }
  }

  /// Dialog show thông báo chỉ có 1 nút ok hoặc cancel
  static Future<void> showNotification(
    BuildContext context,
    String title,
    String message,
  {Function? onClickOk,String? okLabel}
  ) async {
    final OkCancelResult result = await showOkAlertDialog(
      context: context,
      title: title,
      message: message,
      barrierDismissible: false,
      okLabel: okLabel
    );
    if(result == OkCancelResult.ok&& onClickOk!=null){
      onClickOk();
    }
  }

  /// Dialog show thông báo chỉ có 1 nút ok và 1 nút cancel
  static Future<void> showDialogTwoButton(
      BuildContext context, String title, String message, Function onClickOk,
      {String? cancelLabel, String? okLabel,Function? onClickCancel}) async {
    final OkCancelResult result = await showOkCancelAlertDialog(
        context: context,
        title: title,
        message: message,
        okLabel: okLabel ?? Translate.text("agree"),
        cancelLabel: cancelLabel ?? Translate.text("close"));
    print(result);
    if(result==OkCancelResult.ok){
      onClickOk();
    }
    if(result==OkCancelResult.cancel&& onClickCancel!=null){
      onClickCancel();
    }
  }

}

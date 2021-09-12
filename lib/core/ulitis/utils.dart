import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:io' show Platform;
import 'dart:io' as IO;
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils with ChangeNotifier {


  // format số tiền có chứa phần thập phân
  static formatDecimalCurrency(String valueStr, bool isAllowZero) {
    try {
      if(valueStr=="null") return "null";
      if(isInteger(double.parse(valueStr))){
        return _formatCurrency(valueStr);
      }else{
        String val = valueStr;
        String firstVal;
        String secordVal;
        if (val.toString().indexOf('.') > 0) {
          firstVal =
              valueStr.substring(0, val.indexOf('.')).replaceAll('/\D/g', '');
          secordVal =
              val.substring(val.indexOf('.'), val.length).replaceAll('/\D/g', '');
          if (secordVal.length > 2) {
            if (secordVal.length >= 3) {
              secordVal = secordVal.substring(0, 3);
            } else {
              secordVal = secordVal.substring(0, 2);
            }
          }
          if (isAllowZero && secordVal.length == 2 && secordVal.contains('0')) {
            secordVal = '';
          }
          val = _formatCurrency(firstVal) + secordVal;
        } else {
          val = _formatCurrency(valueStr.toString().replaceAll('/\D/g', ''));
        }
        return val;
      }

    } catch (e) {
      throw e;
    }
  }
  // Kiểm tra 1 số có phải interger ko
  static bool isInteger(num value) =>
      value is int || value == value.roundToDouble();
  static String getCurrentTimeStringRequest() {
    final DateTime nowDate = DateTime.now();
    return nowDate.year.toString() +
        format2Digit(nowDate.month) +
        format2Digit(nowDate.day) +
        format2Digit(nowDate.hour) +
        format2Digit(nowDate.minute) +
        format2Digit(nowDate.second);
  }

  static String moneyFormat(String price) {
    if (price.length > 2) {
      var value = price;
      value = value.replaceAll(RegExp(r'\D'), '');
      value = value.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), ',');
      return value;
    } else {
      return price;
    }
  }

  static String formatMoneyCurrency(String price, String currency) {
    final String textPrice = moneyFormat(price) + "/" + currency;

    return textPrice; // 10,000 VND
  }

  /// sample: 2 => 02 */
  static String format2Digit(int n) {
    if (n < 10) {
      return '0' + n.toString();
    } else {
      return n.toString();
    }
  }

  static String getCurrentTimeConvertString(DateTime nowDate) {
    return nowDate.year.toString() +
        format2Digit(nowDate.month) +
        format2Digit(nowDate.day) +
        format2Digit(nowDate.hour) +
        format2Digit(nowDate.minute) +
        format2Digit(nowDate.second);
  }

  static String sha256Convert(String value) {
    return sha256.convert(utf8.encode(value)).toString();
  }

  static String enCry(String userName, String pass) {
    int start = int.parse(userName.substring(5, 6));
    int end = int.parse(userName.substring(userName.length - 1));
    if (start == end && (end == 0 || end.toString() == '0')) {
      start = 5;
      end = 8;
    }
    return randomString(end) + pass + randomString(start);
  }

  static String randomString(int numbers) {
    String text = "";
    const String possible =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

    for (var i = 0; i < numbers; i++) {
      var dom = Random().nextDouble();
      var random = dom * possible.length;

      var flo = random.floor();
      text += charAt(possible, flo);
    }
    return text;
  }

  static String charAt(String subject, int position) {
    if (subject is! String ||
        subject.length <= position ||
        subject.length + position < 0) {
      return '';
    }
    final int _realPosition =
        position < 0 ? subject.length + position : position;
    return subject[_realPosition];
  }

  static String trimText(String text) {
    String textStr;
    textStr = text.trim();
    return textStr;
  }

  static formatText(data) {
    var str = data;
    str = str.replaceAll(RegExp(r"(\à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ)"), 'a');
    str = str.replaceAll(RegExp(r"(\À|Á|Ạ|Ả|Ã|Â|Ầ|Ấ|Ậ|Ẩ|Ẫ|Ă|Ằ|Ắ|Ặ|Ẳ|Ẵ)"), 'A');
    str = str.replaceAll(RegExp(r"(\è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ)"), 'e');
    str = str.replaceAll(RegExp(r"(\ì|í|ị|ỉ|ĩ)"), 'i');
    str = str.replaceAll(RegExp(r"(\ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ)"), 'o');
    str = str.replaceAll(RegExp(r"(\ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ)"), 'u');
    str = str.replaceAll(RegExp(r"(\ỳ|ý|ỵ|ỷ|ỹ)"), 'y');
    str = str.replaceAll(RegExp(r"(\đ)"), 'd');
    str = str.replaceAll(RegExp(r"(\È|É|Ẹ|Ẻ|Ẽ|Ê|Ề|Ế|Ệ|Ể|Ễ)"), 'E');
    str = str.replaceAll(RegExp(r"(\Ì|Í|Ị|Ỉ|Ĩ)"), 'I');
    str = str.replaceAll(RegExp(r"(\Ò|Ó|Ọ|Ỏ|Õ|Ô|Ồ|Ố|Ộ|Ổ|Ỗ|Ơ|Ờ|Ớ|Ợ|Ở|Ỡ)"), 'O');
    str = str.replaceAll(RegExp(r"(\Ù|Ú|Ụ|Ủ|Ũ|Ư|Ừ|Ứ|Ự|Ử|Ữ)"), 'U');
    str = str.replaceAll(RegExp(r"(\Ỳ|Ý|Ỵ|Ỷ|Ỹ)"), 'Y');
    str = str.replaceAll(RegExp(r"(\Đ)"), 'D');
    return str;
  }

  static String _formatCurrency(String text) {
    /// Check xem có dấu trừ ở trươc không để trả về cả dấu "-"
    bool hasSub = text[0] == "-";
    if (text.contains(".")) {
      text = text.substring(0, text.indexOf("."));
    }
    if (text.length > 2) {
      if (text[0] == "0") {
        text = text.substring(1, text.length);
      }
      var value = text;
      value = value.replaceAll(RegExp(r'\D'), '');
      value = value.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), ',');
      if (hasSub) {
        return "- " + value;
      } else {
        return value;
      }
    }
    if (hasSub) {
      return "-" +
          text.replaceAll(
              RegExp(r'\D'), ''); // nhập không phải là số thì xóa hết
    } else {
      return text.replaceAll(
          RegExp(r'\D'), ''); // nhập không phải là số thì xóa hết
    }
  }

  static String formatCurrencyTonNumberString(String text) {
    return text.replaceAll(RegExp(r'\D'), '');
  }

  static String formatStringBalanceSplit(String text) {
    String balance = text.split("/")[0];
    return balance;
  }

  static String generateConvertDevice(String dataIn, signature) {
    var encodedKey = utf8.encode(signature); // signature=encryption key
    var hMacSha256 = new Hmac(sha256, encodedKey); // HMAC-SHA256 with key
    var bytesDataIn = utf8.encode(dataIn); // encode the data to Unicode.
    var digest = hMacSha256.convert(bytesDataIn); // encrypt target data
    String singedValue = digest.toString();
    return singedValue;
  }

  static formatDateSelect(String valueDate) {
    DateTime dateTime = DateFormat('yyyy-MM-dd').parse(valueDate);
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  static String convertFileToBase64(
      {required String imagePath, required bool concatHead}) {
    String base64Image = "";
    Uint8List bytes = IO.File(imagePath).readAsBytesSync();
    if (concatHead == true) {
      base64Image = "data:image/jpg;base64," + base64Encode(bytes);
      print(base64Image);
      return base64Image;
    } else {
      print(base64Encode(bytes));
      return base64Image = base64Encode(bytes);
    }
  }

  static String getBase64FormateFile(String path) {
    IO.File file = IO.File(path);
    print('File is = ' + file.toString());
    Uint8List fileInByte = file.readAsBytesSync();
    String fileInBase64 = base64Encode(fileInByte);
    print(fileInBase64);

    return fileInBase64;
  }

  late int _count;
  timeCountDown(int _time, bool start) {
    _count = _time;
    if (start == true) {
      const oneSec = const Duration(seconds: 1);
      new Timer.periodic(
        oneSec,
        (Timer timer) {
          if (_time == 0) {
            timer.cancel();
            print("kết thúc ");
          } else {
            _time--;
            _count = _time;
            print(_time);
          }
        },
      );
    }
    _count;
    notifyListeners();
  }

  get getTimeCountDown => _count;

}

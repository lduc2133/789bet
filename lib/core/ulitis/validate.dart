import 'package:flutter/material.dart';

class Validate {
  static bool checkIsEmtype(List<TextEditingController> listController) {
    if (isEmtypeInput(listController) == true) {
      print("vui long nhap ");
      return true;
    }
    return false;
  }

  static bool isEmtypeInput(List<TextEditingController> listController) =>
      listController.any((element) => element.text.isEmpty);
}

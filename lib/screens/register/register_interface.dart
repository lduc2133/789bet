import 'package:flutter/material.dart';

abstract class IRegisterInterface {
  Future<dynamic> register(BuildContext context,Map<String,dynamic> body);
}

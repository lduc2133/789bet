import 'package:flutter/material.dart';

abstract class ILoginInterface {
  Future<dynamic> login(BuildContext context,Map<String,dynamic> body);

}

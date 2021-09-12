import 'package:capcha/models/captcha_model.dart';
import 'package:flutter/material.dart';

abstract class IApplicationInterface {
  Future<CaptchaModel?> getCaptcha(BuildContext context);

}

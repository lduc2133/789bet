import 'package:capcha/core/constants/name_icon.dart';
import 'package:capcha/core/widgets/image/local_image_widget.dart';
import 'package:capcha/screens/application/application_service.dart';
import 'package:capcha/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/Splash';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    Future.delayed(const Duration(seconds: 3), () async {
      Navigator.pushNamedAndRemoveUntil(
          context, LoginScreen.routeName, (route) => false);
    });
    return Scaffold(
      body: Center(child: Image.asset(json_splash)),
    );
  }
}

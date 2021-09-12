import 'package:capcha/screens/change_language/language_notifier.dart';
import 'package:capcha/screens/change_language/language_screen.dart';
import 'package:capcha/screens/home/home_notifier.dart';
import 'package:capcha/screens/home/home_screen.dart';
import 'package:capcha/screens/login/login_notifier.dart';
import 'package:capcha/screens/login/login_screen.dart';
import 'package:capcha/screens/register/register_notifier.dart';
import 'package:capcha/screens/register/register_screen.dart';
import 'package:capcha/screens/splash/splash_screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
      case SplashScreen.routeName:
        return MaterialPageRoute(builder: (_) => SplashScreen());

      case LoginScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider<LoginNotifier>(
                create: (context) => LoginNotifier(
                      context,
                    ),
                child: LoginScreen()));
      case RegisterScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider<RegisterNotifier>(
                create: (context) => RegisterNotifier(
                      context,
                    ),
                child: RegisterScreen()));

      case LanguageScreen.routeName:
        return MaterialPageRoute(
            fullscreenDialog: true,
            builder: (_) => ChangeNotifierProvider<LanguageNotifier>(
                create: (context) => LanguageNotifier(
                      context,
                    ),
                child: LanguageScreen()));
      case HomeScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider<HomeNotifier>(
                create: (context) => HomeNotifier(
                      context,
                    ),
                child: HomeScreen()));

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text(
                    'No route defined for ${settings.name}',
                    style: TextStyle(color: Colors.black),
                  )),
                ));
    }
  }
}

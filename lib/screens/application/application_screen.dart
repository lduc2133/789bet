

import 'dart:async';
import 'package:capcha/core/routes.dart';
import 'package:capcha/core/styles/style.dart';
import 'package:capcha/screens/application/application_notifier.dart';
import 'package:capcha/screens/splash/splash_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:provider/provider.dart';


class ApplicationScreen extends StatefulWidget {
  final Iterable<Locale> supportedLocales;
  final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates;
  final Locale locale;

  const ApplicationScreen({
    Key? key,required this.supportedLocales,required this.localizationsDelegates,required this.locale,
  }) : super(key: key);

  @override
  _ApplicationScreenState createState() => _ApplicationScreenState();
}

class _ApplicationScreenState extends State<ApplicationScreen> {


  @override
  Widget build(BuildContext context) {
    final appNotifier = Provider.of<ApplicationNotifier>(context);
    return ScreenUtilInit(
        designSize: const Size(1080 , 1920),
        builder: () => KeyboardDismisser(
          child: MaterialApp(
            navigatorKey: appNotifier.materialKey, // GlobalKey()
            /// Chặn phóng to chữ
            builder: (context, child) {
              return MediaQuery(
                child: child!,
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              );
            },
            supportedLocales: widget.supportedLocales,
            localizationsDelegates: widget.localizationsDelegates,
            locale: widget.locale,
            theme: ThemeData(
              appBarTheme: AppBarTheme(
                centerTitle: true
              ),
              primaryColor: clr_f44336,
              primaryColorLight: clr_ff7961,
              primaryColorDark: clr_ba000d,
            ),
            debugShowCheckedModeBanner: false,
            onGenerateRoute: Routers.generateRoute,
            initialRoute: SplashScreen.routeName,
          ),
        ));
  }
}

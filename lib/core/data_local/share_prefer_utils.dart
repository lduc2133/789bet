import 'dart:convert';
import 'package:capcha/core/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SharePreferUtils {



  static Future<String> getLanguage() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(Constants.LANGUAGE_APP)??'vi';
  }

  static Future<void> setLanguage(String newLanguage) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(Constants.LANGUAGE_APP, newLanguage);
  }


  static clearSharePrefer() async {
    print("clearSharePrefer");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

}



import 'package:capcha/core/constants/name_icon.dart';
import 'package:capcha/core/data_local/share_prefer_utils.dart';
import 'package:capcha/core/public/global.dart';
import 'package:capcha/models/language_model.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';


class LanguageNotifier extends ChangeNotifier{
  List<LanguageModel> listLanguage = [];

  LanguageNotifier(BuildContext context){
    initData();
  }

  void initData() {
    listLanguage.add(LanguageModel("Việt Nam","vi","vi_VN",png_language_vn));
    listLanguage.add(LanguageModel("English","en","en_US",png_language_en));
  }

  void setLanguage(BuildContext context, LanguageModel item) {
    context.setLocale(Locale(item.locale));
    SharePreferUtils.setLanguage(item.locale);
    initLanguage(item.locale);
    Navigator.pop(context);
  }
  static void initLanguage(String languageCurrent) {
    switch (languageCurrent) {
      case "vi":
        Global.language = 'vi';
        Global.imageLanguageSelected= png_language_vn;
        break;
      case "en":
        Global.language = 'en';
        Global.imageLanguageSelected= png_language_en;
        break;
      default:
        Global.imageLanguageSelected= png_language_en;
        Global.language = 'en';
    }
  }
}
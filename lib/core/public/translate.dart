import 'package:easy_localization/easy_localization.dart';

class Translate {

  static String text(
    String translate,
  ) {
    try{
      if (translate.isNotEmpty) {
        return translate.tr();
      } else {
        return 'key isEmpty';
      }
    }catch(e){
      print(e);
      return translate;
    }
  }
}

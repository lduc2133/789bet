
import 'package:capcha/core/data_local/share_prefer_utils.dart';
import 'package:capcha/screens/application/application_notifier.dart';
import 'package:capcha/screens/application/application_screen.dart';
import 'package:capcha/screens/change_language/language_notifier.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'core/public/global.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await dotenv.load(fileName: 'assets/configs/.env');
  initDataEnv();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  final String languageCurrent = await SharePreferUtils.getLanguage();
  LanguageNotifier.initLanguage(languageCurrent);
  runApp(EasyLocalization(
    supportedLocales: [Locale('en'), Locale('vi'),],
    path: 'assets/translations',
    fallbackLocale: Locale('vi'),
    startLocale: Locale(languageCurrent),
    useOnlyLangCode: true,
    child: LoadApp(),
  ));
}

void initDataEnv() {
  Global.baseUrl = dotenv.env['BASE_URL'].toString();
  Global.timeOutApi = int.parse(dotenv.env['TIME_OUT_API'].toString());
}

class LoadApp extends StatelessWidget {
  const LoadApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ApplicationNotifier>(
        create: (context) => ApplicationNotifier(),
        child: ApplicationScreen(
          locale: context.locale,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
        ));
  }
}

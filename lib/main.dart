import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:remember_password/utils/language_util_v2.dart';

import 'app_pages.dart';
import 'color/colors.dart';
import 'database/db_manager.dart';
import 'language/translation_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();
  await DbManager.instance().init();
  Colours.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

   MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    setDesignWHD(750.0, 1624);
    return GetMaterialApp(
      title: '备份密码',
      debugShowCheckedModeBanner: false,
      theme: Colours.themeData(),
      darkTheme: Colours.themeData(),
      initialRoute: '/',
      getPages: AppPages.routes,
      supportedLocales: const [
        Locale('zh', 'CN'),
      ],
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(),
      translations: TranslationService(),
      locale: LanguageUtilV2.initLanguage().toLocale(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}


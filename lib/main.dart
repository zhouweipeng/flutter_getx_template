import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yhlz_flutter_template/langs/translation_service.dart';
import 'package:yhlz_flutter_template/routes/routes.dart';
import 'package:yhlz_flutter_template/store/store.dart';
import 'package:yhlz_flutter_template/style/style.dart';
import 'package:yhlz_flutter_template/utils/utils.dart';
import 'package:yhlz_flutter_template/global.dart';

Future<void> main() async {
  await Global.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(375, 812),
        builder: () => GetMaterialApp(
              title: '元亨利贞',
              theme: AppTheme.common,
              debugShowCheckedModeBanner: false,
              initialRoute: AppPages.initial,
              getPages: AppPages.routes,
              builder: EasyLoading.init(),
              translations: TranslationService(),
              navigatorObservers: [AppPages.observer],
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: AppStore.instance.languages,
              locale: AppStore.instance.locale,
              fallbackLocale: Locale('en', 'US'),
              enableLog: true,
              logWriterCallback: Logger.write,
            ));
  }
}

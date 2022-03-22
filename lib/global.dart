import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getx_template/services/services.dart';
import 'package:flutter_getx_template/store/store.dart';
import 'package:flutter_getx_template/utils/utils.dart';
import 'package:get/get.dart';

/// 初始化服务
class Global {
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    // 设置屏幕方向
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    // 设置应用状态栏样式
    setSystemUi();
    // 设置loading实例样式
    Loading();
    // 异步初始化storage服务
    await Get.putAsync<StorageService>(() => StorageService().init());
    // 初始化应用以及用户对应的store
    Get.put<AppStore>(AppStore());
    Get.put<UserStore>(UserStore());
  }

  static void setSystemUi() {
    if (GetPlatform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }
}

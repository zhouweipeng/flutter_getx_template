import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:yhlz_flutter_template/style/style.dart';

class Loading {
  static init() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCube
      ..maskType = EasyLoadingMaskType.custom
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 36.0
      ..lineWidth = 2
      ..radius = 8
      ..boxShadow = [BoxShadow(color: Colors.transparent)]
      ..backgroundColor = Colors.transparent
      ..indicatorColor = AppColor.primaryColor
      ..textColor = AppColor.primaryColor
      ..maskColor = AppColor.primaryBackground.withOpacity(0.8)
      ..userInteractions = true
      ..dismissOnTap = false;
  }

  static void show([String? text]) {
    EasyLoading.instance.userInteractions = false;
    EasyLoading.show(status: text ?? '加载中');
  }

  static void toast(String text) {
    EasyLoading.showToast(text);
  }

  static void dismiss() {
    EasyLoading.instance.userInteractions = true;
    EasyLoading.dismiss();
  }
}

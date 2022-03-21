import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yhlz_flutter_template/style/style.dart';

import 'index.dart';

class WelcomePage extends GetView<WelcomeController> {
  @override
  Widget build(BuildContext context) => DecoratedBox(
      decoration: BoxDecoration(color: AppColor.primaryBackground),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/logo.png', width: 100.w, height: 100.w),
            Text('元亨利贞', style: TextStyle(fontSize: Font.xl))
          ]));
}

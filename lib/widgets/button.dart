import 'package:flutter/material.dart';
import 'package:yhlz_flutter_template/style/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 扁平圆角按钮
Widget btnFlatButtonWidget({
  required VoidCallback onPressed,
  double width = double.infinity,
  double height = 44,
  Color backgroundColor = AppColor.primaryColor,
  String title = 'button',
  Color fontColor = AppColor.lightText,
  FontWeight fontWeight = FontWeight.normal,
  double? fontSize,
}) {
  return Container(
    width: width,
    height: height.w,
    child: TextButton(
      style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          primary: AppColor.defaultColor,
          elevation: 3
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: fontColor,
          fontWeight: fontWeight,
          fontSize: fontSize ?? Font.md,
          height: 1,
        ),
      ),
      onPressed: onPressed,
    ),
  );
}

/// 第三方按钮
Widget btnFlatButtonBorderOnlyWidget({
  required VoidCallback onPressed,
  double width = 88,
  double height = 44,
  required String iconFileName,
}) {
  return Container(
    width: width.w,
    height: height.h,
    child: TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: Radii.smallRadius,
        )),
      ),
      child: Image.asset(
        'assets/images/icons-$iconFileName.png',
      ),
      onPressed: onPressed,
    ),
  );
}

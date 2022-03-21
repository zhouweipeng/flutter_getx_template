import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yhlz_flutter_template/style/style.dart';

/// 输入框
Widget inputTextEdit({
  TextEditingController? controller,
  FocusNode? focusNode,
  TextInputType keyboardType = TextInputType.text,
  String hintText = '请输入内容',
  bool isPassword = false,
  EdgeInsets? margin,
  bool autofocus = false,
}) =>
    Container(
      height: 50.w,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: Radii.smallRadius,
      ),
      child: TextField(
        autofocus: autofocus,
        controller: controller,
        focusNode: focusNode,
        keyboardType: keyboardType,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: hintText,
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColor.borderColor),
                borderRadius: BorderRadius.all(Radius.circular(44.w)))),
        style: TextStyle(color: AppColor.primaryText),
        autocorrect: false,
        // 自动纠正
        obscureText: isPassword, // 隐藏输入内容, 密码框
      ),
    );

/// 搜索框
Widget searchBar(
    {TextEditingController? controller,
      EdgeInsetsGeometry? margin,
      double height = 40,
      String hintText = '搜索',
      bool autofocus = false,
      bool enabled = true,
      bool hidePrefix = false,
      bool hideSuffix = false,
      bool isCenter = false,
      void Function()? onTap}) {
  final fontSize = Font.md;
  final iconSize = Font.xl;
  return Container(
    height: height.w,
    margin: margin,
    decoration: BoxDecoration(
      color: AppColor.grayBackground,
      borderRadius: BorderRadius.circular((height / 2).w),
    ),
    child: TextField(
        controller: controller,
        autofocus: autofocus,
        keyboardType: TextInputType.text,
        enabled: enabled,
        textAlign: isCenter ? TextAlign.center : TextAlign.start,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(fontSize: fontSize),
            contentPadding: EdgeInsets.symmetric(horizontal: Distance.md),
            border: OutlineInputBorder(borderSide: BorderSide.none),
            prefixIcon: hidePrefix ? null : Icon(Icons.search, size: iconSize),
            suffixIcon: hideSuffix
                ? null
                : Icon(Icons.camera_alt_outlined, size: iconSize)),
        style: TextStyle(
          color: AppColor.primaryText,
          fontSize: fontSize,
        ),
        onTap: onTap),
  );
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_getx_template/style/style.dart';
import 'package:flutter_getx_template/widgets/widgets.dart';

import 'index.dart';

class SignInPage extends GetView<SignInController> {
  @override
  Widget build(BuildContext context) {
    final headOffset = Get.mediaQuery.padding.top + 56;
    return Padding(
        padding: EdgeInsets.all(Distance.xxl),
        child: Column(
          children: <Widget>[
            SizedBox(height: headOffset),
            _buildTitle(),
            SizedBox(height: 56),
            _buildForm(),
            _buildAppendText(),
            Spacer(),
            _buildThirdPartyLogin()
          ],
        ));
  }

  // 标题文字
  Widget _buildTitle() {
    return SizedBox(
        width: double.infinity,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(controller.state.title,
                  style: TextStyle(fontSize: Font.xxxl)),
              SizedBox(height: Distance.md),
              Text(controller.state.subtitle,
                  style:
                  TextStyle(fontSize: Font.md, color: AppColor.minorText))
            ]));
  }

  // 登录表单
  Widget _buildForm() {
    final margin = EdgeInsets.only(bottom: Distance.xl);
    return Column(
      children: <Widget>[
        inputTextEdit(
            controller: controller.accountController,
            keyboardType: TextInputType.text,
            hintText: '账号',
            margin: margin),
        inputTextEdit(
            controller: controller.passwordController,
            keyboardType: TextInputType.visiblePassword,
            hintText: '密码',
            isPassword: true,
            margin: margin),
        btnFlatButtonWidget(
          onPressed: controller.handleSignIn,
          backgroundColor: AppColor.primaryColor,
          title: '登录',
        )
      ],
    );
  }

  Widget _buildAppendText() {
    final textStyle = TextStyle(fontSize: Font.md, color: AppColor.minorText);
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TextButton(
              child: Text('注册账号', style: textStyle),
              onPressed: controller.handleNavSignUp),
          TextButton(
              child: Text('忘记密码', style: textStyle),
              onPressed: controller.handleForgetPassword)
        ]);
  }

  // 第三方登录
  Widget _buildThirdPartyLogin() {
    final dividerOffset = Distance.lg;
    final imageSize = 40.w;
    return Column(
      children: <Widget>[
        Row(children: <Widget>[
          Expanded(child: Divider(endIndent: dividerOffset)),
          Text('第三方登录',
              style: TextStyle(fontSize: Font.sm, color: AppColor.minorText)),
          Expanded(child: Divider(indent: dividerOffset))
        ]),
        SizedBox(height: dividerOffset),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: controller.state.thirdPartyList
              .map((e) => RawMaterialButton(
              child: Image.asset(e.icon, width: imageSize),
              onPressed: () => controller.handleThirdPartyLogin(e)))
              .toList(),
        ),
        SizedBox(height: 56)
      ],
    );
  }
}

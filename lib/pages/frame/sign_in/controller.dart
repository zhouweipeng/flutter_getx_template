import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yhlz_flutter_template/apis/apis.dart';
import 'package:yhlz_flutter_template/models/models.dart';
import 'package:yhlz_flutter_template/routes/routes.dart';
import 'package:yhlz_flutter_template/store/store.dart';
import 'package:yhlz_flutter_template/utils/utils.dart';

import 'index.dart';

class SignInController extends GetxController {
  final state = SignInState();
  final accountController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void onReady() {
    super.onReady();
    accountController.text = state.defaultUserName;
    passwordController.text = state.defaultPassWord;
  }

  @override
  void onClose() {
    accountController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // 跳转注册界面
  void handleNavSignUp() {
    Get.toNamed(AppRoutes.sign_up);
  }

  // 忘记密码
  void handleForgetPassword() {
    showToast(msg: '重置密码暂未开放');
  }

  // 执行登录操作
  void handleSignIn() async {
    Loading.show();
    final params = UserLoginRequestParams(
      username: accountController.text,
      password: passwordController.text,
    );
    late UserLoginResponseData userInfo;
    try {
      userInfo = await UserAPI.login(params);
    } catch (e) {
      userInfo = UserLoginResponseData.fromJson(state.testUser);
    }
    UserStore.instance.saveUserInfo(userInfo);
    Loading.dismiss();
    Get.offAndToNamed(AppRoutes.home);
  }

  // 第三方登录
  void handleThirdPartyLogin(ThirdPartyMode e) {
    showToast(msg: '第三方登录暂未开放');
  }
}

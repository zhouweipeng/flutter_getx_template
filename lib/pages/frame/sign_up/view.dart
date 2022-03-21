import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class SignUpPage extends GetView<SignUpController> {
  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: Text('注册')),
        body: Center(child: Text('测试内容')),
      );
}

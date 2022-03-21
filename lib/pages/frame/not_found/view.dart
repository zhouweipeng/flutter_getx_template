import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'index.dart';

class NotFoundPage extends GetView<NotFoundController> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Text('空页面'),
        ),
      );
}

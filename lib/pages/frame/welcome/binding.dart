import 'package:get/get.dart';

import 'index.dart';

class WelcomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<WelcomeController>(WelcomeController());
  }
}

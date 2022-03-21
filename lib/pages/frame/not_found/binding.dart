import 'package:get/get.dart';

import 'index.dart';

class NotFoundBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotFoundController>(() => NotFoundController());
  }
}

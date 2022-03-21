import 'package:get/get.dart';

import 'index.dart';

class EditBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<EditController>(EditController());
  }
}

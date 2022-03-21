import 'package:get/get.dart';

import 'index.dart';

class NotesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotesController>(() => NotesController());
  }
}

import 'package:yhlz_flutter_template/pages/tabbar/index.dart';
import 'package:get/get.dart';

import 'index.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<NotesController>(() => NotesController());
  }
}

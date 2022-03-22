import 'package:get/get.dart';
import 'package:flutter_getx_template/routes/routes.dart';
import 'package:flutter_getx_template/store/store.dart';

import 'index.dart';

class WelcomeController extends GetxController {
  final state = WelcomeState();

  @override
  void onReady() {
    super.onReady();
    delayEnter();
  }

  Future<void> delayEnter() async {
    print('!!!!!!!!!!!!');
    await 2.delay();
    await AppStore.instance.saveAlreadyOpen();
    print('????????????');
    Get.offAndToNamed(AppRoutes.sign_in);
  }
}

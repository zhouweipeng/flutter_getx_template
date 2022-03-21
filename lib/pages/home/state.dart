import 'package:get/get.dart';

class HomeState {
  // 当前 tab 页码
  final _page = 0.obs;
  set page(value) => this._page.value = value;
  get page => this._page.value;
}

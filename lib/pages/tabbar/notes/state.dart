import 'package:get/get.dart';
import 'package:yhlz_flutter_template/models/models.dart';

class NotesState {
  // 笔记列表
  var notes = <Note>[].obs;

  // 加载状态
  var _isLoading = false.obs;
  set isLoading(value) => _isLoading.value = value;
  get isLoading => _isLoading.value;
}

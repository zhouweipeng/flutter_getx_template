import 'package:get/get.dart';

class EditState {
  var _isImportant = false.obs;
  set isImportant(value) => _isImportant.value = value;
  get isImportant => _isImportant.value;

  var _number = 0.obs;
  set number(value) => _number.value = value;
  get number => _number.value;

  var _title = ''.obs;
  set title(value) => _title.value = value;
  get title => _title.value;

  var _description = ''.obs;
  set description(value) => _description.value = value;
  get description => _description.value;

  get isFormValid => _title.isNotEmpty && _description.isNotEmpty;
}

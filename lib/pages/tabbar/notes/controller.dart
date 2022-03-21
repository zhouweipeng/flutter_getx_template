import 'package:get/get.dart';
import 'package:yhlz_flutter_template/models/models.dart';
import 'package:yhlz_flutter_template/routes/routes.dart';
import 'package:yhlz_flutter_template/sqlite/sqlite.dart';

import 'index.dart';

class NotesController extends GetxController {
  final state = NotesState();

  @override
  void onReady() {
    super.onReady();
    refreshNotes();
  }

  Future refreshNotes() async {
    state.isLoading = true;
    state.notes
      ..clear()
      ..addAll(await NotesDatabase.instance.getList());
    state.isLoading = false;
  }

  Future<void> handleCreate({Note? note}) async {
    await Get.toNamed(AppRoutes.edit, arguments: note);
    refreshNotes();
  }
}

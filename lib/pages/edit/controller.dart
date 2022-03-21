import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yhlz_flutter_template/models/models.dart';
import 'package:yhlz_flutter_template/sqlite/sqlite.dart';

import 'index.dart';

class EditController extends GetxController {
  final state = EditState();
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    final note = Get.arguments;
    if (note != null) {
      state
        ..number = note.number
        ..title = note.title
        ..description = note.description
        ..isImportant = note.isImportant;
    }
  }

  void onChangedImportant(bool val) {
    state.isImportant = val;
  }

  void onChangedNumber(int val) {
    state.number = val;
  }

  void onChangedTitle(String val) {
    state.title = val;
  }

  void onChangedDescription(String val) {
    state.description = val;
  }

  void addOrUpdateNote() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    final isUpdating = Get.arguments != null;
    await (isUpdating ? _updateNote : _createNote)();
    Get.back();
  }

  Future<void> _updateNote() async {
    final note = Get.arguments!.copy(
      isImportant: state.isImportant,
      number: state.number,
      title: state.title,
      description: state.description,
    );
    await NotesDatabase.instance.update(note);
  }

  Future<void> _createNote() async {
    final note = Note(
      title: state.title,
      isImportant: state.isImportant,
      number: state.number,
      description: state.description,
      createdTime: DateTime.now(),
    );
    await NotesDatabase.instance.create(note);
  }
}

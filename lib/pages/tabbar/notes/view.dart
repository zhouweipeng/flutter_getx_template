import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yhlz_flutter_template/models/models.dart';
import 'package:yhlz_flutter_template/style/style.dart';

import 'index.dart';

class NotesPage extends GetView<NotesController> {
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(children: [
          _buildCreateButton(),
          _buildLoadingContainer(_buildNotes())
        ]),
      );

  Widget _buildLoadingContainer(Widget content, {String? emptyTip}) =>
      Obx(() => Center(
            child: controller.state.isLoading
                ? CircularProgressIndicator()
                : controller.state.notes.isEmpty
                    ? Text(emptyTip ?? '暂无内容')
                    : content,
          ));

  Widget _buildCreateButton() => MaterialButton(
      child: Text('新增数据'),
      color: AppColor.primaryColor,
      textColor: Color(0xFFFFFFFF),
      onPressed: controller.handleCreate);

  Widget _buildNotes() => Obx(() => Column(
        children: controller.state.notes.map(_buildNoteItem).toList(),
      ));

  Widget _buildNoteItem(Note note) => ListTile(
      title: Text(note.title),
      subtitle: Text(note.description),
      onTap: () => controller.handleCreate(note: note));
}

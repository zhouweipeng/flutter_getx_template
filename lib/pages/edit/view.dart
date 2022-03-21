import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class EditPage extends GetView<EditController> {
  @override
  Widget build(BuildContext context) => Form(
      key: controller.formKey,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Obx(() => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildSubmitButton(),
                _buildActionArea(),
                _buildTitle(),
                SizedBox(height: 8),
                _buildDescription(),
              ],
            )),
      ));

  Widget _buildSubmitButton() => Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            onPrimary: Colors.white,
            // 数据为空时修改按钮主题色为灰色
            primary: controller.state.isFormValid ? null : Colors.grey.shade700,
          ),
          onPressed: controller.addOrUpdateNote,
          child: Text('保存'),
        ),
      );

  Widget _buildActionArea() => Row(
        children: [
          Switch(
            value: controller.state.isImportant ?? false,
            onChanged: controller.onChangedImportant,
          ),
          Expanded(
            child: Slider(
              value: (controller.state.number ?? 0).toDouble(),
              min: 0,
              max: 5,
              divisions: 5,
              onChanged: (val) => controller.onChangedNumber(val.toInt()),
            ),
          )
        ],
      );

  Widget _buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: controller.state.title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Title',
        ),
        validator: (val) =>
            val != null && val.isEmpty ? 'The title cannot be empty' : null,
        onChanged: controller.onChangedTitle,
      );

  Widget _buildDescription() => TextFormField(
        maxLines: 5,
        initialValue: controller.state.description,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Description',
        ),
        validator: (val) => val != null && val.isEmpty
            ? 'The description cannot be empty'
            : null,
        onChanged: controller.onChangedDescription,
      );
}

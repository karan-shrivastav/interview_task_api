import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextInputType? inputType;
  final int? length;
  final TextEditingController? controller;
  final String? label;
  const TextFieldWidget(
      {super.key, this.controller, this.label, this.length, this.inputType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: inputType ?? TextInputType.text,
      maxLength: length,
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
      ),
    );
  }
}

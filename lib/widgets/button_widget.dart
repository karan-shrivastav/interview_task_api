import 'package:flutter/material.dart';
import 'package:interview_task_api/widgets/text_widget.dart';

class ButtonWidget extends StatelessWidget {
  final String? title;
  final Color? color;
  final Color? titleColor;
  const ButtonWidget({
    super.key,
    this.title,
    this.color,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: color ?? const Color(0xFF778beb),
          borderRadius: BorderRadius.circular(25)),
      child: TextWidget(
        title: title,
        textAlign: TextAlign.center,
        color: titleColor ?? Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

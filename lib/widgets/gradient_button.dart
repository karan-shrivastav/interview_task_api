import 'package:flutter/material.dart';
import 'package:interview_task_api/widgets/text_widget.dart';

class GradientButton extends StatelessWidget {
  final String title;
  final double?height;
  const GradientButton({super.key, required this.title, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height??50,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF169ada),
              Color(0xFF12bad4),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(25)),
      child:  Center(
        child: TextWidget(
          title: title,
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

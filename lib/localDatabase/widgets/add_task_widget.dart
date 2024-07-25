import 'package:flutter/material.dart';
import 'package:interview_task_api/widgets/button_widget.dart';
import 'package:interview_task_api/widgets/gradient_button.dart';
import '../../models/sql_model.dart';
import '../../widgets/common_text_field.dart';

class AddTaskLocal extends StatefulWidget {
  final SQLModel? todo;
  final ValueChanged<Map<String, String>> onSubmit;
  const AddTaskLocal({
    super.key,
    this.todo,
    required this.onSubmit,
  });

  @override
  State<AddTaskLocal> createState() => _AddTaskLocalState();
}

class _AddTaskLocalState extends State<AddTaskLocal> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          top: 30,
          bottom: 50,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonTextField(
              controller: _titleController,
              hintText: 'Title',
            ),
            const SizedBox(
              height: 15,
            ),

            const SizedBox(
              height: 15,
            ),
            CommonTextField(
              controller: _descriptionController,
              hintText: 'Descripttion',
            ),

            const SizedBox(
              height: 35,
            ),

            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const  ButtonWidget(
                      titleColor: Color(0xFF7c7a95),
                      color: Color(0xFFefeff9),
                      title: "Cancel",
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final name = _titleController.text;
                      final mobile = _descriptionController.text;
                      final email = _emailController.text;
                      widget.onSubmit({
                        'title': name,
                        'description': mobile,
                        'created_at' : email,
                      });
                    },
                    child: const GradientButton(
                      height: 40,
                      title: "Add",
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

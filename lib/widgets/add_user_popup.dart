import 'package:flutter/material.dart';
import 'package:interview_task_api/models/task_model.dart';
import 'package:interview_task_api/providers/task_provider.dart';
import 'package:interview_task_api/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/user_model.dart';
import '../providers/user_provider.dart';
import 'button_widget.dart';
import 'common_text_field.dart';
import 'gradient_button.dart';

class AddUserPopup extends StatefulWidget {
  final int? userId;
  const AddUserPopup({super.key, this.userId});

  @override
  State<AddUserPopup> createState() => _AddUserPopupState();
}

class _AddUserPopupState extends State<AddUserPopup> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  var uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();
    final tasks = taskProvider.tasks;
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
                    child: const ButtonWidget(
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

                        final data = TaskModel(
                            userId: widget.userId,
                            title: _titleController.text,
                            completed: false);
                        tasks.add(data);
                        context.read<TaskProvider>().saveData([...tasks]);
                        _titleController.clear();
                        _descriptionController.clear();
                        _mobileController.clear();
                        Navigator.of(context).pop();
                        setState(() {});
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
    // return Column(
    //   mainAxisSize: MainAxisSize.min,
    //   children: [
    //     const Text(
    //       'Add User',
    //       style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
    //     ),
    //     const SizedBox(
    //       height: 10,
    //     ),
    //     TextFieldWidget(
    //       controller: _nameController,
    //       label: 'Enter your Name',
    //     ),
    //     const SizedBox(
    //       height: 10,
    //     ),
    //     TextFieldWidget(
    //       controller: _emailController,
    //       label: 'Enter your Email',
    //     ),
    //     const SizedBox(
    //       height: 10,
    //     ),
    //     TextFieldWidget(
    //       length: 10,
    //       controller: _mobileController,
    //       label: 'Enter your Phone number',
    //       inputType: TextInputType.number,
    //     ),
    //     const SizedBox(
    //       height: 10,
    //     ),
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         SizedBox(
    //           width: 100,
    //           child: ElevatedButton(
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //             },
    //             child: const Text('Back'),
    //           ),
    //         ),
    //         SizedBox(
    //           width: 100,
    //           child: ElevatedButton(
    //             onPressed: () {
    //               if (_nameController.text.isNotEmpty &&
    //                   _emailController.text.isNotEmpty &&
    //                   _mobileController.text.isNotEmpty) {
    //                 final data = TaskModel(
    //                     userId: widget.userId,
    //                     title: _emailController.text,
    //                     completed: false);
    //                 tasks.add(data);
    //                 context.read<TaskProvider>().saveData([...tasks]);
    //                 _nameController.clear();
    //                 _emailController.clear();
    //                 _mobileController.clear();
    //                 Navigator.of(context).pop();
    //                 setState(() {});
    //               }
    //             },
    //             child: const Text('Save'),
    //           ),
    //         ),
    //       ],
    //     )
    //   ],
    // );
  }
}

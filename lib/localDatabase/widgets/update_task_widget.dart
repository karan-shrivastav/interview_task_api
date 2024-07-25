import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/task_provider.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/common_text_field.dart';
import '../../widgets/gradient_button.dart';

class UpdateTaskWidget extends StatefulWidget {
  final String? title;
  final int? id;
  const UpdateTaskWidget({super.key, this.title, this.id});

  @override
  State<UpdateTaskWidget> createState() => _UpdateTaskWidgetState();
}

class _UpdateTaskWidgetState extends State<UpdateTaskWidget> {
  final TextEditingController? titleController = TextEditingController();

  @override
  void initState() {
    titleController?.text  = widget.title??'';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom),
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
              controller: titleController,
              hintText: 'Title',
            ),
            const SizedBox(
              height: 50,
            ),
            // CommonTextField(
            //   maxLength: 10,
            //   textInputType: TextInputType.number,
            //   controller: _mobileController,
            //   hintText: 'Mobile',
            // ),
            // const SizedBox(
            //   height: 15,
            // ),
            // CommonTextField(
            //   controller: _emailController,
            //   hintText: 'Email',
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
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
                  width: 25,
                ),
                Expanded(
                    child: InkWell(
                      onTap: () {
                        final String title = titleController?.text??'';
                        context.read<TaskProvider>().updateItem(
                         widget.id,
                          title,
                        );
                        setState(() {});
                        Navigator.of(context).pop();
                      },
                      child: const GradientButton(
                        height: 40,
                        title: "Update",
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );;
  }
}

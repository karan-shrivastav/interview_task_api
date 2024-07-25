import 'package:flutter/material.dart';
import 'package:interview_task_api/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../providers/user_provider.dart';

class EditUserPopup extends StatefulWidget {
  final int? id;
  final String? name;
  final String? email;
  final String? phoneNumber;
  const EditUserPopup({
    super.key,
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
  });

  @override
  State<EditUserPopup> createState() => _EditUserPopupState();
}

class _EditUserPopupState extends State<EditUserPopup> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  @override
  void initState() {
    _nameController.text = widget.name ?? '';
    _emailController.text = widget.email ?? '';
    _mobileController.text = widget.phoneNumber ?? '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final users = userProvider.users;
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Add User',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFieldWidget(
            controller: _nameController,
            label: 'Enter your Name',
          ),
          const SizedBox(
            height: 10,
          ),
          TextFieldWidget(
            controller: _emailController,
            label: 'Enter your Email',
          ),
          const SizedBox(
            height: 10,
          ),
          TextFieldWidget(
            length: 10,
            controller: _mobileController,
            label: 'Enter your Phone number',
            inputType: TextInputType.number,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Back'),
                ),
              ),
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    if (_nameController.text.isNotEmpty &&
                        _emailController.text.isNotEmpty &&
                        _mobileController.text.isNotEmpty) {
                      final data = UserModel(
                          id: widget.id,
                          name: _nameController.text,
                          email: _emailController.text,
                          phone: _mobileController.text);

                      users.add(data);
                      context.read<UserProvider>().saveData([...users]);
                      _nameController.clear();
                      _emailController.clear();
                      _mobileController.clear();
                      Navigator.of(context).pop();
                      setState(() {});
                    }
                  },
                  child: const Text('Save'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

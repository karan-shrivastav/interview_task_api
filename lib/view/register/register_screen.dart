import 'package:flutter/material.dart';
import 'package:interview_task_api/providers/register_user_provider.dart';
import 'package:provider/provider.dart';
import '../../widgets/common_text_field.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/text_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 35,
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: TextWidget(
                        title: "Sign up",
                        color: Color(0xFF1bc2c1),
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    CommonTextField(
                      controller: _userNameController,
                      hintText: 'Username',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CommonTextField(
                      controller: _emailController,
                      hintText: 'Email',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CommonTextField(
                      controller: _passwordController,
                      hintText: 'Password',
                    ),
                  ],
                ),
              ),
              InkWell(
                  onTap: () {
                    Map<String, dynamic> dataMap = {
                      "userName": _userNameController.text,
                      "email": _emailController.text,
                      "password": _passwordController.text,
                    };
                    context
                        .read<RegisterUserProvider>()
                        .registerUser(dataMap, context);
                    _passwordController.clear();
                    _userNameController.clear();
                    _emailController.clear();
                    setState(() {});
                  },
                  child: const GradientButton(
                    title: 'Sign up',
                  )),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

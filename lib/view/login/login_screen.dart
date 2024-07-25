import 'package:flutter/material.dart';
import 'package:interview_task_api/providers/login_provider.dart';
import 'package:provider/provider.dart';
import '../../widgets/common_text_field.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/text_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                        title: "Login",
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
                     context.read<LoginProvider>().loginUser(dataMap, context);
                    _passwordController.clear();
                    _userNameController.clear();
                    _emailController.clear();
                    setState(() {});
                  },
                  child: const GradientButton(
                    title: 'Login',
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

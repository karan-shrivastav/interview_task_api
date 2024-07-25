import 'package:flutter/material.dart';
import 'package:interview_task_api/providers/create_user_provider.dart';
import 'package:interview_task_api/providers/login_provider.dart';
import 'package:interview_task_api/providers/register_user_provider.dart';
import 'package:interview_task_api/providers/task_provider.dart';
import 'package:interview_task_api/providers/user_provider.dart';
import 'package:interview_task_api/view/register/register_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => CreateUserProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => RegisterUserProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
       home: RegisterScreen(),
       // home: MyHomePage(),
      ),
    );
  }
}

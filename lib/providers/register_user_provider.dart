import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:interview_task_api/view/login/login_screen.dart';
import 'dart:convert';
import '../utils/toas_alert.dart';

class RegisterUserProvider with ChangeNotifier {
  Future<Map<String, dynamic>> registerUser(Map<String, dynamic> data, BuildContext context) async {
    final response = await http.post(
      Uri.parse('https://reqres.in/api/register'),
      body: jsonEncode(data),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      ToastAlert.showToast("User registered successfully");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create post');
    }
  }
  notifyListeners();
}

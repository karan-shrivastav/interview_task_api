import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:interview_task_api/view/screens/my_home_page.dart';
import 'dart:convert';
import '../utils/toas_alert.dart';

class LoginProvider with ChangeNotifier {
  Future<Map<String, dynamic>> loginUser(
      Map<String, dynamic> data, BuildContext context) async {
    final response = await http.post(
      Uri.parse('https://reqres.in/api/login'),
      body: jsonEncode(data),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      ToastAlert.showToast("User Login successfully");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage()),
      );
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to Login');
    }
  }
  notifyListeners();
}

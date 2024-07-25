import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateTaskProvider with ChangeNotifier {
  Future<Map<String, dynamic>> createTask(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/todos'),
      body: jsonEncode(data),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 201) {
      print(response.body);
      print(response.statusCode);

      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create post');
    }
  }
  notifyListeners();
}

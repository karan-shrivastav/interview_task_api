import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateUserProvider with ChangeNotifier {
  Future<Map<String, dynamic>> createUser() async {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
      body: jsonEncode(<String, dynamic>{
        "name": "Karan",
        "username": "karan124",
        "email": "karan@gmail.com",
        "address": {
          "street": "Kulas Light",
          "suite": "Apt. 556",
          "city": "Gwenborough",
          "zipcode": "92998-3874",
          "geo": {"lat": "-37.3159", "lng": "81.1496"}
        },
        "phone": "1-770-736-8031 x56442",
        "website": "hildegard.org",
        "company": {
          "name": "Romaguera-Crona",
          "catchPhrase": "Multi-layered client-server neural-net",
          "bs": "harness real-time e-markets"
        }

        // "name" : "subh",
        // 'email': "subh@gmail.com",
        // "username": "Hey1234",
        // "address": "Heyy 2345 jfjf ",
        // "phone": "8888888888",
        // "website": "google.com",
        // "company": "qqqqqq",
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 201) {
      print(response.body);
      print(response.statusCode);

      return jsonDecode(response.body);
    } else {
      // If the server did not return a 201 CREATED response,
      // throw an exception.
      throw Exception('Failed to create post');
    }



  }
  notifyListeners();
}

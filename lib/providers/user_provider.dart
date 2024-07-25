import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../models/user_model.dart';


class UserProvider with ChangeNotifier {
  List<UserModel> _users = [];

  List<UserModel> get users => _users;

  void saveData(List<UserModel> value) {
    _users = value;
    notifyListeners();
  }

  void deleteData(int id) {
    _users.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  Future<List<UserModel>> getAllUsers() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      List<UserModel> users =
          jsonData.map((user) => UserModel.fromJson(user)).toList();
      //notifyListeners();
      saveData(users);
      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }
}

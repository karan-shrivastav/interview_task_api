import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../models/task_model.dart';


class TaskProvider with ChangeNotifier {
  List<TaskModel> _tasks = [];

  List<TaskModel> get tasks => _tasks;

  void saveData(List<TaskModel> value) {
    _tasks = value;
    notifyListeners();
  }

  void deleteData(int id) {
    _tasks.removeWhere((element) => element.id == id);

    notifyListeners();
  }

  void updateItem(int? id, String? newTitle,) {
    _tasks = _tasks.map((item) {
        if (item.id == id) {
          return TaskModel( title: newTitle, completed: false);
        }
        return item;
      }).toList();
    notifyListeners();
  }

  Future<List<TaskModel>> getAllTasks() async {
    final response =
    await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      List<TaskModel> tasks =
      jsonData.map((tasks) => TaskModel.fromJson(tasks)).toList();
      //notifyListeners();
      saveData(tasks);
      updateItem(0, '');
      return tasks;
    } else {
      throw Exception('Failed to load users');
    }
  }
}

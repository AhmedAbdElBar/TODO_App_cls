import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter_r5_s2/todo/tasks%20screen/task_modle.dart';

class HttpDb {
  static const String baseUrl =
      "https://6aaf2a6eee9c55c910bf38cc.mockapi.io/tasks_management/";

  Future<bool> addTask(TaskModel task) async {
    final taskMap = task.toMap();
    final taskJson = jsonEncode(taskMap);
    final response = await post(
      Uri.parse("$baseUrl/tasks"),
      body: taskJson,
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateTask(TaskModel task) async {
    final taskMap = task.toMap();
    final taskJson = jsonEncode(taskMap);
    final response = await put(
      Uri.parse("$baseUrl/tasks/${task.id}"),
      body: taskJson,
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<TaskModel>?> getTasks() async {
    final response = await get(Uri.parse("$baseUrl/tasks"));
    if (response.statusCode == 200 || response.statusCode == 201) {
      final tasksMap = jsonDecode(response.body) as List;
      List<TaskModel> tasks = [];
      for (var taskMap in tasksMap) {
        tasks.add(TaskModel.fromMap(taskMap));
      }
      return tasks;
    } else {
      return null;
    }
  }

  Future<bool> removeTask(String id) async {
    final response = await delete(Uri.parse("$baseUrl/tasks/$id"));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> removeAllTasks(List<TaskModel> tasks) async {
    for (var task in tasks) {
      await removeTask(task.id!);
    }
    return true;
  }
}

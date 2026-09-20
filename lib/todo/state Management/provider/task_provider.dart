import 'package:flutter/material.dart';
import 'package:flutter_r5_s2/todo/DataBase/remote%20db/http_db.dart';
import 'package:flutter_r5_s2/todo/tasks%20screen/task_modle.dart';

// import '../../DataBase/local db/SQFLite db/sqflite_task_db.dart';

class TaskProvider extends ChangeNotifier {
  List<TaskModel> _tasks = [];

  List<TaskModel> get tasks => _tasks;
  // final SqfliteTaskDb db = SqfliteTaskDb();
  final HttpDb db = HttpDb();

  Future<void> initTasks() async {
    final result = await db.getTasks();
    if (result != null) {
      _tasks = result;
    }
    notifyListeners();
  }

  Future<void> addToList(TaskModel task) async {
    final sucsess = await db.addTask(task);
    if (sucsess) {
      _tasks.add(task);
      notifyListeners();
    }
  }

  Future<void> removeTask(TaskModel task) async {
    final success = await db.removeTask(task.id);
    if (success) {
      _tasks.removeWhere((element) => element.id == task.id);
      notifyListeners();
    }
  }

  Future<void> clearAll() async {
    if (_tasks.isNotEmpty) {
      final removedTasks = [..._tasks];
      final success = await db.removeAllTasks(removedTasks);
      if (success) {
        _tasks.clear();
        notifyListeners();
      }
    }
  }

  Future<void> toggleIsCompleted(TaskModel task) async {
    final updatedTask = TaskModel(
      id: task.id,
      title: task.title,
      subtitle: task.subtitle,
      isCompleted: !task.isCompleted,
    );

    final index = _tasks.indexWhere((element) => element.id == task.id);

    if (index != -1) {
      final success = await db.updateTask(updatedTask);
      if (success) {
        _tasks[index] = updatedTask;
        notifyListeners();
      }
    }
  }
}

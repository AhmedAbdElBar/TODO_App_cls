import 'package:flutter/material.dart';
import 'package:flutter_r5_s2/todo/tasks%20screen/task_modle.dart';
import '../DataBase/local db/SQFLite db/sqflite_task_db.dart';

class TaskProvider extends ChangeNotifier {
  List<TaskModel> tasks = [];
  SqfliteTaskDb db = SqfliteTaskDb();

  Future<void> initTasks() async {
    tasks = await db.getAllTasks();
    notifyListeners();
  }

  Future<void> addToList(TaskModel task) async {
    tasks.add(task);
    await db.addTask(task);
    notifyListeners();
  }

  Future<void> rmoveFormList(TaskModel task) async {
    tasks.removeWhere((element) => element.id == task.id);
    await db.removeTask(task.id);
    notifyListeners();
  }

  Future<void> clearAll() async {
    tasks.clear();
    await db.clearAllTasks();
    notifyListeners();
  }

  Future<void> toggleIsCompleted(TaskModel task) async {
    final updatedTask = TaskModel(
      id: task.id,
      title: task.title,
      subtitle: task.subtitle,
      isCompleted: !task.isCompleted,
    );

    await db.updateTask(updatedTask);

    final index = tasks.indexWhere((element) => element.id == task.id);

    if (index != -1) {
      tasks[index] = updatedTask;
      notifyListeners();
    }
  }
}

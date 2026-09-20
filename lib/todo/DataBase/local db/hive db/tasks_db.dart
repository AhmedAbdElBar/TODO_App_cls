import 'package:flutter_r5_s2/todo/tasks%20screen/task_modle.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'adapter.dart';

class HiveTasksDb {
  static const String boxName = "tasks";
  static Future<void> init() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(Adapter().typeId)) {
      Hive.registerAdapter(Adapter());
    }
    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox<TaskModel>(boxName);
    }
  }

  static Future<void> addOrUpdateTask(TaskModel task) async {
    await Hive.box<TaskModel>(boxName).put(task.id, task);
  }

  static Future<void> removeTask(String id) async {
    await Hive.box<TaskModel>(boxName).delete(id);
  }

  static Future<List<TaskModel>> getAllTasks() async {
    final box = Hive.box<TaskModel>('tasks');
    return [...box.values];
  }

  static Future<void> removeAllTasks() async {
    await Hive.box<TaskModel>(boxName).clear();
  }
}

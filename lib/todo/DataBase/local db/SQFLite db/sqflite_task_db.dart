import 'package:flutter_r5_s2/todo/tasks%20screen/task_modle.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteTaskDb {
  static late Database database;
  final String tableName = "Tasks";

  Future<void> initialDb() async {
    var databaseDirectoryPath = await getDatabasesPath();
    String filePath = '$databaseDirectoryPath/tasks.db';
    database = await openDatabase(
      filePath,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE $tableName(id TEXT PRIMARY KEY,title TEXT,subtitle TEXT,isCompleted INTEGER)",
        );
      },
    );
  }

  Future<void> addTask(TaskModel task) async {
    database.insert(tableName, task.toMap());
  }

  Future<void> removeTask(String id) async {
    await database.delete(tableName, where: "id = ?", whereArgs: [id]);
  }

  Future<List<TaskModel>> getTasks() async {
    final List<Map<String, dynamic>> tasksMaps = await database.query(
      tableName,
    );
    List<TaskModel> tasks = [];
    for (var map in tasksMaps) {
      tasks.add(TaskModel.fromMap(map));

    }
    return tasks;
    
  }

  Future<void> removeAllTasks() async {
    await database.delete(tableName);
  }

  Future<void> updateTask(TaskModel task) async {
    await database.update(
      tableName,
      task.toMap(),
      where: "id = ?",
      whereArgs: [task.id],
    );
  }
}

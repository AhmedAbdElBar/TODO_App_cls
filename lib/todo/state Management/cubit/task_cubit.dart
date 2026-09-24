import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_r5_s2/todo/DataBase/remote%20db/http_db.dart';
import 'package:flutter_r5_s2/todo/tasks%20screen/task_modle.dart';

// import '../../DataBase/local db/hive db/hive_tasks_db.dart';

class TasksCubit extends Cubit<List<TaskModel>> {
  TasksCubit() : super([]) {
    loadTasks();
  }
  // final HiveTasksDb db = HiveTasksDb();
  final HttpDb db = HttpDb();
  Future<void> loadTasks() async {
    // await db.init();

    final tasks = await db.getTasks() ?? [];
    emit(tasks);
  }

  void addTask(TaskModel task) {
    final newList = [...state, task];
    emit(newList);
    db.addTask(task);
  }

  void removeTask(TaskModel task) {
    if (state.isNotEmpty) {
      final newList = [...state];
      newList.remove(task);
      emit(newList);
      db.removeTask(task.id!);
    }
  }

  void removeAllTasks() {
    final tasks = [...state];
    emit([]);
    db.removeAllTasks(tasks);
  }

  void toggleIsCompleted(TaskModel task) {
    task.isCompleted = !task.isCompleted;
    emit([...state]);
    db.updateTask(task);//for cubit
    // db.addTask(task); for provider
  }
}
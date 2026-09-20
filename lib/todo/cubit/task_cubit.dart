// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_r5_s2/todo/hive%20db/tasks_db.dart';
// import 'package:flutter_r5_s2/todo/tasks%20screen/task_modle.dart';

// class TasksCubit extends Cubit<List<TaskModel>> {
//   TasksCubit() : super([]) {
//     loadTasks();
//   }

//   Future<void> loadTasks() async {
//     await TasksDb.init();

//     final tasks = await TasksDb.getAllTasks();

//     emit(tasks);
//   }

//   void addTask(TaskModel task) {
//     final newList = [...state, task];
//     TasksDb.addOrUpdateTask(task);
//     emit(newList);
//   }

//   void removeTask(TaskModel task) {
//     final newList = [...state];
//     newList.remove(task);
//     TasksDb.removeTask(task.id);
//     emit(newList);
//   }

//   void removeAllTasks() {
//     TasksDb.removeAllTasks();
//     emit([]);
//   }

//   void isCompleted(TaskModel task) {
//     task.isCompleted = !task.isCompleted;
//     TasksDb.addOrUpdateTask(task);
//     emit([...state]);
//   }
// }

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_r5_s2/todo/Data/firebase/firebase_db.dart';
import 'package:flutter_r5_s2/todo/Data/remote%20db/http_db.dart';
import 'package:flutter_r5_s2/todo/presentation/state%20Management/cubit/task_state.dart';
import 'package:flutter_r5_s2/todo/Data/task_modle.dart';

// import '../../DataBase/local db/hive db/hive_tasks_db.dart';

class TasksCubit extends Cubit<TaskState> {
  TasksCubit() : super(TasksInitial()) {
    loadTasks();
  }
  // final HiveTasksDb db = HiveTasksDb();
  final HttpDb db = HttpDb();
  //-------------------------
  /// get all tasks
  //-------------------------
  Future<void> loadTasks() async {
    // await db.init();
    emit(TasksLoading([]));
    try {
      FirebaseDb.getTasks().listen((tasks) {
        emit(TasksSuccess(tasks));
      });
    } catch (e) {
      emit(TasksError(e.toString()));
    }
  }

  //-------------------------
  /// add new task
  //-------------------------
  Future<void> addTask(TaskModel task) async {
    try {
      if (state is TasksSuccess) {
        final currentTasks = (state as TasksSuccess).tasks;

        emit(TasksLoading(currentTasks));

        FirebaseDb().addTask(task);
      }
    } catch (e) {
      emit(TasksError(e.toString()));
    }
  }

  //-------------------------
  /// toggle is completed value
  //-------------------------
  Future<void> toggleIsCompleted(TaskModel task) async {
    try {
      if (state is TasksSuccess) {
        final currentTasks = (state as TasksSuccess).tasks;

        task.isCompleted = !task.isCompleted;
        emit(TasksLoading(currentTasks));
        FirebaseDb().updataTask(task);
      }
    } catch (e) {
      emit(TasksError(e.toString()));
    }
  }

  //-------------------------
  /// remove task by id
  //-------------------------
  Future<void> removeTask(TaskModel task) async {
    try {
      if (state is TasksSuccess) {
        final currentTasks = (state as TasksSuccess).tasks;
        emit(TasksLoading(currentTasks));

        FirebaseDb().removeTask(task);
      }
    } catch (e) {
      emit(TasksError(e.toString()));
    }
  }

  //-------------------------
  /// clear all tasks
  //-------------------------
  Future<void> removeAllTasks() async {
    try {
      if (state is TasksSuccess) {
        FirebaseDb().removeAllTasks();
      }
    } catch (e) {
      emit(TasksError(e.toString()));
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
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
    emit(TasksLoading());
    try {
      final tasks = await db.getTasks() ?? [];
      emit(TasksSuccess(tasks));
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

        emit(TasksLoading());

        final success = await db.addTask(task);

        if (success) {
          emit(TasksSuccess([...currentTasks, task]));
        } else {
          emit(TasksError("Failed to add task"));
        }
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
        emit(TasksLoading());

        final success = await db.removeTask(task.id!);
        final updatedTasks = currentTasks
            .where((element) => element.id != task.id)
            .toList();
        if (success) {
          emit(TasksSuccess([...updatedTasks]));
        } else {
          emit(TasksError("Failed to remove Task"));
        }
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
        final tasks = [...(state as TasksSuccess).tasks];
        emit(TasksLoading());
        await db.removeAllTasks(tasks);
        emit(TasksSuccess([]));
      }
    } catch (e) {
      emit(TasksError(e.toString()));
    }
  }
  //-------------------------
  /// toggle is completed value
  //-------------------------
  Future<void> toggleIsCompleted(TaskModel task) async {
    task.isCompleted = !task.isCompleted;
    emit(TasksLoading());

    try {
      await db.updateTask(task);
      final tasks = await db.getTasks() ?? [];
      emit(TasksSuccess([...tasks]));
    } catch (e) {
      emit(TasksError(e.toString()));
    } //for cubit
    // db.addTask(task); for provider
  }
}

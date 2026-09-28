import 'package:flutter_r5_s2/todo/tasks%20screen/task_modle.dart';

abstract class TaskState {}

class TasksInitial extends TaskState {}

class TasksLoading extends TaskState {}

class TasksSuccess extends TaskState {
  final List<TaskModel> tasks;
  TasksSuccess(this.tasks);
}

class TasksError extends TaskState {
  final String error;
  TasksError(this.error);
}

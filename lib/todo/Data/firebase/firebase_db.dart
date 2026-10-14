import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_r5_s2/todo/Data/task_modle.dart';

class FirebaseDb {
  static final _taskCollectionRef = FirebaseFirestore.instance
      .collection(usersCollectionName)
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection(taskCollectionName);
  static const String usersCollectionName = "users";
  static const String taskCollectionName = "tasks";
  Future<void> addTask(TaskModel task) async {
    final docRef = _taskCollectionRef.doc();
    task.id = docRef.id;
    await docRef.set(task.toMap());
  }

  Future<void> updataTask(TaskModel task) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      return;
    }
    final docRef = _taskCollectionRef.doc(task.id);
    await docRef.update(task.toMap());
  }

  Future<void> removeTask(TaskModel task) async {
    final docRef = _taskCollectionRef.doc(task.id);
    await docRef.delete();
  }

  Future<void> removeAllTasks() async {
    final tasksSnapshot = await _taskCollectionRef.get();
    for (final doc in tasksSnapshot.docs) {
      await doc.reference.delete();
    }
  }

  static Stream<List<TaskModel>> getTasks() {
    final taskStream = _taskCollectionRef.snapshots();

    Stream<List<TaskModel>> streamTasks = taskStream.map((querySnapshot) {
      final taskDocs = querySnapshot.docs;
      final List<TaskModel> tasks = taskDocs.map((doc) {
        final taskMap = doc.data();
        final task = TaskModel.fromMap(taskMap);
        return task;
      }).toList();
      return tasks;
    });
    return streamTasks;
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_r5_s2/todo/presentation/features/auth/presentation/login/login.dart';
import 'package:flutter_r5_s2/todo/presentation/features/add%20task/add_task_screen.dart';

class Mainscreen extends StatelessWidget {
  const Mainscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData || snapshot.data != null) {
          return AddTaskScreen();
        } else {
          return Login();
        }
      },
    );
  }
}

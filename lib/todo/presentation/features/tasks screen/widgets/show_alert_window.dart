import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../state Management/cubit/task_cubit.dart';
import '../../../state Management/cubit/task_state.dart';

void showAlertWindow(
  BuildContext context,
  String title,
  String buttom,
  String content,
  VoidCallback deleteFunc,
) {
  showDialog(
    context: context,
    builder: (dialogContext) {
      return BlocListener<TasksCubit, TaskState>(
        listener: (context, state) {
          if (state is TasksSuccess) {
            Navigator.pop(dialogContext);
          }

          if (state is TasksError) {
            Navigator.pop(dialogContext);

            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: BlocBuilder<TasksCubit, TaskState>(
          builder: (context, state) {
            final isLoading = state is TasksLoading;

            return AlertDialog(
              backgroundColor: Colors.white,
              title: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00265C),
                ),
              ),

              content: Text(
                content,
                style: TextStyle(color: Color(0xFF00265C)),
              ),

              actions: [
                if (!isLoading)
                  TextButton(
                    onPressed: () {
                      Navigator.pop(dialogContext);
                    },
                    child: const Text("Cancel"),
                  ),

                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          deleteFunc();
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(buttom),
                ),
              ],
            );
          },
        ),
      );
    },
  );
}

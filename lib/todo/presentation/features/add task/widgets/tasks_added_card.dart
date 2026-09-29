import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../state Management/cubit/task_cubit.dart';
import '../../../state Management/cubit/task_state.dart';

class TasksAddedCard extends StatelessWidget {
  const TasksAddedCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  color: Color(0xFF0D1B4C),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF0D1B4C).withOpacity(0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Consumer<TaskProvider>(
                    //   builder: (context, taskProvider, child) {
                    BlocBuilder<TasksCubit, TaskState>(
                      builder: (context, state) {
                        if (state is TasksLoading) {
                          return const Center(
                            child: const SizedBox(
                              key: ValueKey('loading'),
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            ),
                          );
                        }
                        if (state is TasksError) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(state.error)));
                        }
                        if (state is TasksSuccess) {
                          return Text(
                            '${state.tasks.length}',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Tasks Added",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.75),
                      ),
                    ),
                  ],
                ),
              );
  }
}
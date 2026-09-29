import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_r5_s2/todo/presentation/features/tasks%20screen/widgets/show_alert_window.dart';
import 'package:flutter_r5_s2/todo/presentation/state%20Management/cubit/task_cubit.dart';
import 'package:flutter_r5_s2/todo/presentation/state%20Management/cubit/task_state.dart';
import 'package:flutter_r5_s2/todo/presentation/features/tasks%20screen/widgets/section_header.dart';
import 'package:flutter_r5_s2/todo/presentation/features/tasks%20screen/widgets/task_card.dart';

// import 'package:flutter_r5_s2/todo/state%20Management/provider/task_provider.dart';
// import 'package:provider/provider.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final tasksProvider = context.read<TaskProvider>();
    final tasksCubit = context.read<TasksCubit>();

    return Scaffold(
      backgroundColor: Color(0xFFF3F6FC),

      appBar: AppBar(
        backgroundColor: Color(0xFF00265C),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'My Tasks',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<TasksCubit, TaskState>(
          builder: (context, state) {
            if (state is TasksError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.error)));
            }

            if (state is TasksSuccess||state is TasksLoading) {
              final tasks = state is TasksSuccess
                  ? state.tasks
                  : (state as TasksLoading).tasks;
              final unCompletedTasks = tasks
                  .where((task) => !task.isCompleted)
                  .toList();

              final completedTasks = tasks
                  .where((task) => task.isCompleted)
                  .toList();

              return tasks.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.hourglass_empty_rounded,
                            size: 100,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 20),
                          Text(
                            "No Tasks Yet!",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        Expanded(
                          // child: Consumer<TaskProvider>(
                          //   builder: (context, taskProvider, child) {
                          child: Column(
                            children: [
                              SectionHeader(
                                icon: Icons.menu_open_rounded,
                                title: 'UnCompleted Tasks',
                                count: unCompletedTasks.length,
                              ),

                              const SizedBox(height: 10),

                              unCompletedTasks.isEmpty
                                  ? Center(child: Text("no Tasks yet"))
                                  : Expanded(
                                      child: ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: unCompletedTasks.length,
                                        itemBuilder: (context, index) {
                                          return TaskCard(
                                            task: unCompletedTasks[index],

                                            deleteFunc: () {
                                              tasksCubit.removeTask(
                                                unCompletedTasks[index],
                                              );
                                            },

                                            isCompleted: () {
                                              tasksCubit.toggleIsCompleted(
                                                unCompletedTasks[index],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                            ],
                          ),
                          //   },
                          // ),
                        ),

                        const SizedBox(height: 12),

                        const Divider(color: Color(0xFFD7DEEA), thickness: 1),

                        const SizedBox(height: 12),

                        Expanded(
                          // child: Consumer<TaskProvider>(
                          //   builder: (context, taskProvider, child) {
                          child: Column(
                            children: [
                              SectionHeader(
                                icon: Icons.task_alt_rounded,
                                title: 'Completed Tasks',
                                count: completedTasks.length,
                              ),

                              const SizedBox(height: 10),

                              completedTasks.isEmpty
                                  ? Center(child: Text("no Tasks yet"))
                                  : Expanded(
                                      child: ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: completedTasks.length,
                                        itemBuilder: (context, index) {
                                          return TaskCard(
                                            task: completedTasks[index],

                                            deleteFunc: () {
                                              tasksCubit.removeTask(
                                                completedTasks[index],
                                              );
                                            },

                                            isCompleted: () {
                                              tasksCubit.toggleIsCompleted(
                                                completedTasks[index],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                            ],
                          ),
                          //   },
                          // ),
                        ),
                      ],
                    );
            }

            return const SizedBox();
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF2D63E8),
        foregroundColor: Colors.white,
        elevation: 4,

        onPressed: () {
          showAlertWindow(
            context,
            "clear all tasks",
            "clear all",
            "are you sure !",
            () {
              tasksCubit.removeAllTasks();
            },
          );
        },

        child: const Icon(Icons.clear_all_rounded, size: 26),
      ),
    );
  }
}

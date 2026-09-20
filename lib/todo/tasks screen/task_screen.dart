import 'package:flutter/material.dart';
import 'package:flutter_r5_s2/todo/provider/task_provider.dart';
import 'package:flutter_r5_s2/todo/tasks%20screen/section_header.dart';
import 'package:flutter_r5_s2/todo/tasks%20screen/task_card.dart';
import 'package:provider/provider.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tasksProvider = context.read<TaskProvider>();

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
        child: Column(
          children: [
            Expanded(
              child: Consumer<TaskProvider>(
                builder: (context, taskProvider, child) {
                  final unCompletedTasks = tasksProvider.tasks
                      .where((task) => !task.isCompleted)
                      .toList();

                  return Column(
                    children: [
                      SectionHeader(
                        icon: Icons.menu_open_rounded,
                        title: 'UnCompleted Tasks',
                        count: unCompletedTasks.length,
                      ),

                      const SizedBox(height: 10),

                      Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: unCompletedTasks.length,
                          itemBuilder: (context, index) {
                            return TaskCard(
                              task: unCompletedTasks[index],

                              deleteFunc: () {
                                taskProvider.rmoveFormList(
                                  unCompletedTasks[index],
                                );
                              },
                              isCompleted: () {
                                taskProvider.toggleIsCompleted(
                                  unCompletedTasks[index],
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            const Divider(color: Color(0xFFD7DEEA), thickness: 1),

            const SizedBox(height: 12),

            Expanded(
              child: Consumer<TaskProvider>(
                builder: (context, taskProvider, child) {
                  final completedTasks = tasksProvider.tasks
                      .where((task) => task.isCompleted)
                      .toList();
                  return Column(
                    children: [
                      SectionHeader(
                        icon: Icons.task_alt_rounded,
                        title: 'Completed Tasks',
                        count: completedTasks.length,
                      ),

                      const SizedBox(height: 10),

                      Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: completedTasks.length,
                          itemBuilder: (context, index) {
                            return TaskCard(
                              task: completedTasks[index],

                              deleteFunc: () {
                                taskProvider.rmoveFormList(
                                  completedTasks[index],
                                );
                              },
                              isCompleted: () {
                                taskProvider.toggleIsCompleted(
                                  completedTasks[index],
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF2D63E8),
        foregroundColor: Colors.white,
        elevation: 4,
        onPressed: () {
          tasksProvider.clearAll();
        },
        child: const Icon(Icons.clear_all_rounded, size: 26),
      ),
    );
  }
}

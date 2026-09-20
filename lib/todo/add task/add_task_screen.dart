import 'package:flutter/material.dart';
import 'package:flutter_r5_s2/todo/add%20task/add_card.dart';
import 'package:flutter_r5_s2/todo/state%20Management/provider/task_provider.dart';
import 'package:flutter_r5_s2/todo/tasks%20screen/task_modle.dart';
import 'package:flutter_r5_s2/todo/tasks%20screen/task_screen.dart';
import 'package:provider/provider.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    context.read<TaskProvider>().initTasks();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFF3FB),
      appBar: AppBar(
        title: const Text(
          "Add New Task",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF0D1B4C),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.task_alt_rounded, color: Color(0xFF0D1B4C), size: 120),
              const SizedBox(height: 20),
              Text("Create new task", style: TextStyle(fontSize: 20)),
              Text(
                "Add a title and description for your task",
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              AddCard(
                titleController: _titleController,
                descriptionController: _descriptionController,
                func: () {
                  context.read<TaskProvider>().addToList(
                    TaskModel(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      title: _titleController.text.trim(),
                      subtitle: _descriptionController.text.trim(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 25),
              Container(
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
                    Consumer<TaskProvider>(
                      builder: (context, taskProvider, child) {
                        return Text(
                          '${taskProvider.tasks.length}',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
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
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: OutlinedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TaskScreen()),
            );
          },
          icon: const Icon(Icons.list_alt, color: Color(0xFF0D1B4C)),
          label: const Text(
            "View All Tasks",
            style: TextStyle(color: Color(0xFF0D1B4C)),
          ),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(48),
            side: const BorderSide(color: Color(0xFF0D1B4C), width: 1.4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}

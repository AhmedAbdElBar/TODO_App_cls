import 'package:flutter/material.dart';
import 'package:flutter_r5_s2/todo/tasks%20screen/task_modle.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final VoidCallback deleteFunc;
  final VoidCallback isCompleted;

  const TaskCard({
    super.key,
    required this.task,
    required this.deleteFunc,
    required this.isCompleted,
  });

  static const Color navy = Color(0xFF00265C);
  static const Color primaryBlue = Color(0xFF2D63E8);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),

        leading: Container(
          width: 38,
          height: 38,

          decoration: BoxDecoration(
            color: primaryBlue.withOpacity(0.10),
            shape: BoxShape.circle,
          ),

          child: const Icon(Icons.check, color: primaryBlue, size: 21),
        ),

        title: Text(
          task.title,
          style: const TextStyle(
            color: navy,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),

        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            task.subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
          ),
        ),

        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: deleteFunc,
              tooltip: 'Delete',

              icon: const Icon(Icons.delete_outline_rounded, color: Colors.red),
            ),

            Checkbox(
              activeColor: primaryBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              value: task.isCompleted,
              onChanged: (value) {
                isCompleted();
              },
            ),
          ],
        ),
      ),
    );
  }
}

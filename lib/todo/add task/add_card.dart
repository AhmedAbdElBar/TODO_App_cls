import 'package:flutter/material.dart';

class AddCard extends StatelessWidget {
  final TextEditingController _titleController;
  final TextEditingController _descriptionController;
  final VoidCallback _func;
  const AddCard({
    super.key,
    required this._titleController,
    required this._descriptionController,
    required this._func,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              cursorColor: Color(0xFF2563EB),
              decoration: InputDecoration(
                labelText: "Title",
                labelStyle: const TextStyle(color: Color(0xFF1E3A8A)),
                prefixIcon: const Icon(
                  Icons.task_alt,
                  color: Color(0xFF1E3A8A),
                ),
                filled: true,
                fillColor: Color(0xFFEFF3FB),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Color(0xFF1E3A8A).withOpacity(0.15),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFF2563EB),
                    width: 1.5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              cursorColor: Color(0xFF2563EB),
              decoration: InputDecoration(
                labelText: "Description",
                labelStyle: const TextStyle(color: Color(0xFF1E3A8A)),
                alignLabelWithHint: true,
                prefixIcon: const Icon(
                  Icons.description_outlined,
                  color: Color(0xFF1E3A8A),
                ),
                filled: true,
                fillColor: Color(0xFFEFF3FB),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Color(0xFF1E3A8A).withOpacity(0.15),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFF2563EB),
                    width: 1.5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () {
                  if (_titleController.text.trim().isEmpty ||
                      _descriptionController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("please add the title and description"),
                      ),
                    );
                    return;
                  }

                  _func();

                  _titleController.clear();
                  _descriptionController.clear();
                },
                icon: const Icon(Icons.add),
                label: const Text("Add Task", style: TextStyle(fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

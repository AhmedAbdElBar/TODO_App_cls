import 'package:flutter_r5_s2/todo/tasks%20screen/task_modle.dart';
import 'package:hive_flutter/adapters.dart';

class Adapter extends TypeAdapter<TaskModel> {
  @override
  TaskModel read(BinaryReader reader) {
    final id = reader.readString();
    final title = reader.readString();
    final subtitle = reader.readString();
    final isCompleted = reader.readBool();

    return TaskModel(
      title: title,
      isCompleted: isCompleted,
      id: id,
      subtitle: subtitle,
    );
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, TaskModel obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.title);
    writer.writeString(obj.subtitle);
    writer.writeBool(obj.isCompleted);
  }
}

class TaskModel {
  String? id;
  final String title;
  final String subtitle;
  bool isCompleted;

  TaskModel({
    this.id,
    required this.title,
    required this.subtitle,
    this.isCompleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "subtitle": subtitle,
      "isCompleted": isCompleted, //? 1 : 0,//for SQFLite
    };
  }

  TaskModel.fromMap(Map<String, dynamic> map)
    : id = map["id"],
      title = map["title"],
      subtitle = map["subtitle"],
      isCompleted = map["isCompleted"]; //== 1;//for SQFLite
}

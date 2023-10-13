class TaskModel {
  int? id;
  late String taskName;

  TaskModel({this.id, required this.taskName});

  Map<String, dynamic> toMap() {
    return {'id': id, 'taskName': taskName};
  }

  TaskModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    taskName = map['taskName'];
  }
}

import 'package:task_manager_application/data/models/task_item.dart';

class TaskListWrapper {
  String? status;
  List<TaskItem>? taskList;

  TaskListWrapper({this.status, this.taskList});

  TaskListWrapper.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskList = <TaskItem>[];
      json['data'].forEach((v) {
        taskList!.add(new TaskItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.taskList != null) {
      data['data'] = this.taskList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



import 'package:task_manager_application/data/models/task_by_status_data.dart';

class CountByStatusWrapper {
  String? status;
  List<TaskByStatusData>? listOfTaskByStatusData;

  CountByStatusWrapper({this.status, this.listOfTaskByStatusData});

  CountByStatusWrapper.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      listOfTaskByStatusData = <TaskByStatusData>[];
      json['data'].forEach((v) {
        listOfTaskByStatusData!.add(new TaskByStatusData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.listOfTaskByStatusData != null) {
      data['data'] = this.listOfTaskByStatusData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



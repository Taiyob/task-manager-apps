import 'package:task_manager_application/data/models/user_data.dart';

class LoginResponseModel {
  String? status;
  String? token;
  UserData? userData;

  LoginResponseModel({this.status, this.token, this.userData});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    userData = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['token'] = this.token;
    if (this.userData != null) {
      data['data'] = this.userData!.toJson();
    }
    return data;
  }
}



import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_application/data/models/user_data.dart';

class AuthController {
  static String? accessToken;
  static UserData? userData;

  static Future<void> saveUserData(UserData userData)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('userData', jsonEncode(userData.toJson(),),);
    AuthController.userData = userData;
  }

  static Future<UserData?> getUserData() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? result =  sharedPreferences.getString('userData');
    if(result == null){
      return null;
    }
    final user =  UserData.fromJson(jsonDecode(result));
    AuthController.userData = user;
    return user;
  }

  static Future<void> saveUserToken(String token) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('token', token);
    accessToken = token;
  }

  static Future<String?> getUserToken() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }

  static Future<bool> isUserLoggedIn() async{
    final result = await getUserToken();
    print(result);
    accessToken = result;
    bool isLoginState =  result != null;
    if(isLoginState){
      await getUserData();
    }
    return isLoginState;
  }

  static Future<void> clearUserData() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}
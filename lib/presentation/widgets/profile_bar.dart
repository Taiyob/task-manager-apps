import 'package:flutter/material.dart';
import 'package:task_manager_application/app.dart';
import 'package:task_manager_application/presentation/controllers/auth_controller.dart';
import 'package:task_manager_application/presentation/screens/auth/sign_in_screen.dart';
import 'package:task_manager_application/presentation/screens/update_profile_screen.dart';

import '../utils/app_colors.dart';

PreferredSizeWidget get profileBar{
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: AppColors.themeColor,
    title: GestureDetector(
      onTap: (){
        Navigator.push(TaskManager.navigatorKey.currentState!.context, MaterialPageRoute(builder: (context)=>UpdateProfileScreen(),),);
      },
      child: Row(
        children: [
          CircleAvatar(),
          SizedBox(width: 12,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Oli Ullah', style: TextStyle(fontSize: 16, color: Colors.white),),
                Text('oli1412001@gmail.com', style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w400,),),
              ],
            ),
          ),
          IconButton(onPressed: ()async{
            await AuthController.clearUserData();
            Navigator.pushAndRemoveUntil(TaskManager.navigatorKey.currentState!.context, MaterialPageRoute(builder: (context)=>SignInScreen()), (route) => false);
          }, icon: Icon(Icons.logout),),
        ],
      ),
    ),
  );
}
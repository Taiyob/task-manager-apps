import 'package:flutter/material.dart';
import 'package:task_manager_application/presentation/controllers/auth_controller.dart';
import 'package:task_manager_application/presentation/screens/main_bottom_nav_screen.dart';
import 'package:task_manager_application/presentation/widgets/background_widget.dart';

import '../widgets/app_logo_widget.dart';
import 'auth/sign_in_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen()async{
    await Future.delayed(const Duration(seconds: 3));
    bool isLoggedIn = await AuthController.isUserLoggedIn();
    if(mounted){
      if(isLoggedIn){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const MainBottomNavScreen(),),);
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const SignInScreen(),),);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BackgroundWidget(child: Center(child: AppLogo(),),),
    );
  }
}



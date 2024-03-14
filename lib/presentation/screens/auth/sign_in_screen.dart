import 'package:flutter/material.dart';
import 'package:task_manager_application/data/models/login_response.dart';
import 'package:task_manager_application/data/models/response_object.dart';
import 'package:task_manager_application/data/services/network_caller.dart';
import 'package:task_manager_application/presentation/controllers/auth_controller.dart';
import 'package:task_manager_application/presentation/screens/auth/sign_up_screen.dart';
import 'package:task_manager_application/presentation/screens/main_bottom_nav_screen.dart';
import 'package:task_manager_application/presentation/widgets/background_widget.dart';
import 'package:task_manager_application/presentation/widgets/snack_bar_message_widget.dart';

import '../../../data/utilities/urls.dart';
import 'email_verification_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTEC = TextEditingController();
  final TextEditingController _passwordTEC = TextEditingController();
  bool _isLoginInprogress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100,),
                  Text('Get Started With', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 16,),
                  TextFormField(
                    controller: _emailTEC,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true){
                        return 'Enter your email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: _passwordTEC,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true){
                        return 'Enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16,),
                  SizedBox(width: double.infinity, child: Visibility(
                    visible: _isLoginInprogress == false,
                    replacement: const Center(child: CircularProgressIndicator()),
                    child: ElevatedButton(onPressed: (){
                      if(_formKey.currentState!.validate()){
                        _signIn();
                      }
                    }, child: const Icon(Icons.arrow_circle_right_outlined)),
                  )),
                  const SizedBox(height: 60,),
                  Center(child: TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const EmailVerificationScreen(),),);
                  }, child: const Text('Forgot Password'),),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?",style: TextStyle(fontSize: 16,color: Colors.black54),),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignUpScreen()));
                      }, child: const Text('Sign up'),),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signIn() async{
    _isLoginInprogress = true;
    setState(() {});
    Map<String, dynamic> inputParams = {
      "email" : _emailTEC.text.trim(),
      "password" : _passwordTEC.text,
    };
    final ResponseObject response = await NetworkCaller.postRequest(Urls.login, inputParams, fromSignIn: true);
    _isLoginInprogress = false;
    setState(() {});
    if(response.isSuccess){
      if(!mounted){
        return;
      }
      LoginResponseModel loginResponseModel = LoginResponseModel.fromJson(response.responseBody);
      print(loginResponseModel.userData?.firstName);
      await AuthController.saveUserData(loginResponseModel.userData!);
      await AuthController.saveUserToken(loginResponseModel.token!);
      if(mounted){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const MainBottomNavScreen(),), (route) => false);
      }
    }else{
      if(mounted){
        showSnackBarMessageWidget(context, response.errorMessage ?? 'Login Failed! Try Again');
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailTEC.dispose();
    _passwordTEC.dispose();
  }
}

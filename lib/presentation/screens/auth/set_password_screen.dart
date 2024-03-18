import 'package:flutter/material.dart';
import 'package:task_manager_application/data/services/network_caller.dart';
import 'package:task_manager_application/data/utilities/urls.dart';
import 'package:task_manager_application/presentation/screens/auth/sign_in_screen.dart';

import '../../widgets/background_widget.dart';
import '../../widgets/snack_bar_message_widget.dart';


class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key, required this.email, required this.otp});

  final email;
  final otp;

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTEC = TextEditingController();
  final TextEditingController _confirmPasswordTEC = TextEditingController();
  bool _setPasswordInprogress = false;
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
                  SizedBox(height: 100,),
                  Text('Set Password', style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(height: 4,),
                  Text('Minimum length password 8 characters with letter and number combination', style: TextStyle(fontSize: 15,color: Colors.grey,),),
                  SizedBox(height: 24,),
                  TextFormField(
                    controller: _passwordTEC,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                    validator: (String? value){

                    },
                  ),
                  SizedBox(height: 8,),
                  TextFormField(
                    controller: _confirmPasswordTEC,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                    ),
                    validator: (String? value){

                    },
                  ),
                  SizedBox(height: 16,),
                  SizedBox(width: double.infinity, child: ElevatedButton(onPressed: (){
                    _setPasswordRequest();
                  }, child: Text('Confirm'))),
                  SizedBox(height: 32,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Have account?",style: TextStyle(fontSize: 16,color: Colors.black54),),
                      TextButton(onPressed: (){
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>SignInScreen()), (route) => false);
                      }, child: Text('Sign in'),),
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

  Future<bool> _setPasswordRequest() async{
    _setPasswordInprogress = true;
    setState(() {});
    Map<String, dynamic> inputParams = {
      "password": _passwordTEC.text.trim(),
      "email" : widget.email,
      "otp" : widget.otp,
    };
    final response = await NetworkCaller.postRequest(Urls.passwordSet, inputParams);
    _setPasswordInprogress = false;
    setState(() {});
    if (response.isSuccess) {
      if (mounted) {
        showSnackBarMessageWidget(
            context, 'Password set successfully! Please Login');
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const SignInScreen(),), (route) => false);
        return true;
      }
      return false;
    } else {
      if (mounted) {
        showSnackBarMessageWidget(
            context, 'Password set Failed, Try Again', true);
        return false;
      }
      return false;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _passwordTEC.dispose();
    _confirmPasswordTEC.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:task_manager_application/data/services/network_caller.dart';
import 'package:task_manager_application/data/utilities/urls.dart';
import 'package:task_manager_application/presentation/controllers/auth_controller.dart';
import 'package:task_manager_application/presentation/screens/auth/pin_verification_screen.dart';

import '../../widgets/background_widget.dart';
import '../../widgets/snack_bar_message_widget.dart';


class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTEC = TextEditingController();
  bool _getEmailVerificationInprogress = false;
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
                  Text('Your Email Address', style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(height: 4,),
                  Text('A six digits verification code will be send to your email address', style: TextStyle(fontSize: 15,color: Colors.grey,),),
                  SizedBox(height: 24,),
                  TextFormField(
                    controller: _emailTEC,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email',
                    ),
                    validator: (String? value){

                    },
                  ),
                  SizedBox(height: 16,),
                  SizedBox(width: double.infinity, child: ElevatedButton(onPressed: (){
                    _verifyEmailRequest(_emailTEC.text.trim());
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PinVerificationScreen(email: _emailTEC.text.trim()),),);
                  }, child: Icon(Icons.arrow_circle_right_outlined))),
                  SizedBox(height: 32,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Have account?",style: TextStyle(fontSize: 16,color: Colors.black54),),
                      TextButton(onPressed: (){
                        Navigator.pop(context);
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

  Future<bool> _verifyEmailRequest(Email) async{
    _getEmailVerificationInprogress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.emailVerification(Email));
    if(response.isSuccess){
      await WriteEmailVerification(Email);
      showSnackBarMessageWidget(context, response.errorMessage ?? "Email verification has been successed");
      return true;
    }else{
      _getEmailVerificationInprogress = false;
      setState(() {});
      if(mounted) {
        showSnackBarMessageWidget(context,
            response.errorMessage ?? "Email verification has been failed");
      }
      return false;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailTEC.dispose();
  }
}

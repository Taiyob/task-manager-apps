import 'package:flutter/material.dart';
import 'package:task_manager_application/presentation/screens/auth/pin_verification_screen.dart';

import '../../widgets/background_widget.dart';


class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTEC = TextEditingController();
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PinVerificationScreen(),),);
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailTEC.dispose();
  }
}

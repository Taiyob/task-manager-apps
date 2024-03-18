import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_application/data/services/network_caller.dart';
import 'package:task_manager_application/data/utilities/urls.dart';
import 'package:task_manager_application/presentation/controllers/auth_controller.dart';
import 'package:task_manager_application/presentation/screens/auth/set_password_screen.dart';
import 'package:task_manager_application/presentation/screens/auth/sign_in_screen.dart';

import '../../utils/app_colors.dart';
import '../../widgets/background_widget.dart';
import '../../widgets/snack_bar_message_widget.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key, required this.email});

  final String email;

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _pinTEC = TextEditingController();
  bool _pinVerificationInprogress = false;
  //final String? userEmail = AuthController.userData!.email;
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
                  SizedBox(
                    height: 100,
                  ),
                  Text('Pin Verification',
                      style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    'A six digits verification code will be send to your email address',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  PinCodeTextField(
                    controller: _pinTEC,
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    keyboardType: TextInputType.number,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      inactiveColor: AppColors.themeColor,
                      selectedFillColor: Colors.white,
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    enableActiveFill: true,
                    onCompleted: (v) {},
                    onChanged: (value) {},
                    appContext: context,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        String? userEmail =
                            await ReadUserData('EmailVerification');
                        if (userEmail != null && widget.email == userEmail) {
                          bool verificationResult =
                              await _pinVerificationRequest(
                                  widget.email, _pinTEC.text.trim());
                          if (verificationResult) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SetPasswordScreen(email: widget.email, otp: _pinTEC.text.trim()),
                              ),
                            );
                          } else {
                            // Show a message indicating that the pin verification failed
                            showSnackBarMessageWidget(
                                context, "Pin verification failed");
                          }
                        } else {
                          // Show a message indicating that the entered pin is incorrect
                          showSnackBarMessageWidget(
                              context, "Incorrect pin entered");
                        }
                      },
                      child: Text('Verified'),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Have account?",
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignInScreen(),
                              ),
                              (route) => false);
                        },
                        child: Text('Sign in'),
                      ),
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

  Future<bool> _pinVerificationRequest(Email, Otp) async {
    _pinVerificationInprogress = true;
    setState(() {});
    final response =
        await NetworkCaller.getRequest(Urls.otpVerification(Email, Otp));
    if (response.statusCode == 200) {
      await WriteOTPVerification(Otp);
      showSnackBarMessageWidget(context,
          response.errorMessage ?? "Pin verification has been Successed");
      return true;
    } else {
      _pinVerificationInprogress = false;
      setState(() {});
      if (mounted) {
        showSnackBarMessageWidget(context,
            response.errorMessage ?? "Pin verification has been failed");
      }
      return false;
    }
  }



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pinTEC.dispose();
  }
}

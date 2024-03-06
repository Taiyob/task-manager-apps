import 'package:flutter/material.dart';
import 'package:task_manager_application/data/services/network_caller.dart';
import 'package:task_manager_application/presentation/widgets/background_widget.dart';
import 'package:task_manager_application/presentation/widgets/snack_bar_message_widget.dart';

import '../../../data/models/response_object.dart';
import '../../../data/utilities/urls.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTEC = TextEditingController();
  final TextEditingController _firstNameTEC = TextEditingController();
  final TextEditingController _lastNameTEC = TextEditingController();
  final TextEditingController _mobileTEC = TextEditingController();
  final TextEditingController _passwordTEC = TextEditingController();
  bool _isRegistrationInprogress = false;
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
                  const SizedBox(
                    height: 60,
                  ),
                  Text(
                    'Join With Us',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _emailTEC,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _firstNameTEC,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: 'First Name',
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your first name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _lastNameTEC,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: 'Last Name',
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your last name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _mobileTEC,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Mobile',
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your mobile number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _passwordTEC,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your password';
                      }
                      if (value!.length <= 6) {
                        return 'Password should more then 6 letter';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: _isRegistrationInprogress == false,
                      replacement:
                          const Center(child: CircularProgressIndicator()),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _signUp();
                          }
                        },
                        child: const Icon(Icons.arrow_circle_right_outlined),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Have account?",
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Sign in'),
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

  Future<void> _signUp() async {
    _isRegistrationInprogress = true;
    setState(() {});
    Map<String, dynamic> inputParams = {
      "email": _emailTEC.text.trim(),
      "firstName": _firstNameTEC.text.trim(),
      "lastName": _lastNameTEC.text.trim(),
      "mobile": _mobileTEC.text.trim(),
      "password": _passwordTEC.text,
    };
    final ResponseObject response =
        await NetworkCaller.postRequest(Urls.registration, inputParams);
    _isRegistrationInprogress = false;
    setState(() {});
    if (response.isSuccess) {
      if (mounted) {
        showSnackBarMessageWidget(
            context, 'Registration Success! Please Login');
        Navigator.pop(context);
      }
    } else {
      if (mounted) {
        showSnackBarMessageWidget(
            context, 'Registration Failed, Try Again', true);
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailTEC.dispose();
    _firstNameTEC.dispose();
    _lastNameTEC.dispose();
    _mobileTEC.dispose();
    _passwordTEC.dispose();
  }
}

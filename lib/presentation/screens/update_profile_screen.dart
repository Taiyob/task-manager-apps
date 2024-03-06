import 'package:flutter/material.dart';
import 'package:task_manager_application/presentation/widgets/background_widget.dart';
import 'package:task_manager_application/presentation/widgets/profile_bar.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _imageTEC = TextEditingController();
  final TextEditingController _firstNameTEC = TextEditingController();
  final TextEditingController _lastNameTEC = TextEditingController();
  final TextEditingController _emailTEC = TextEditingController();
  final TextEditingController _mobileTEC = TextEditingController();
  final TextEditingController _passwordTEC = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileBar,
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 48,),
                  Text('Update Profile', style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 24
                  ),),
                  SizedBox(height: 16,),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 16,horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                          ),
                          child: Text('Photo',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(width: 8,),
                        Text('Image'),
                      ],
                    ),
                  ),
                  SizedBox(height: 8,),
                  TextFormField(
                    controller: _imageTEC,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'image',
                    ),
                  ),
                  SizedBox(height: 8,),
                  TextFormField(
                    controller: _emailTEC,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  SizedBox(height: 8,),
                  TextFormField(
                    controller: _firstNameTEC,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'First Name',
                    ),
                  ),
                  SizedBox(height: 8,),
                  TextFormField(
                    controller: _lastNameTEC,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Last Name',
                    ),
                  ),
                  SizedBox(height: 8,),
                  TextFormField(
                    controller: _mobileTEC,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Mobile',
                    ),
                  ),
                  SizedBox(height: 8,),
                  TextFormField(
                    controller: _passwordTEC,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                  SizedBox(height: 16,),
                  SizedBox(width: double.infinity, child: ElevatedButton(onPressed: (){
                    Navigator.pop(context);
                  }, child: Icon(Icons.arrow_circle_right_outlined))),
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
    _imageTEC.dispose();
    _firstNameTEC.dispose();
    _lastNameTEC.dispose();
    _emailTEC.dispose();
    _mobileTEC.dispose();
    _passwordTEC.dispose();
  }
}

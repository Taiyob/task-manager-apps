import 'package:flutter/material.dart';
import 'package:task_manager_application/presentation/widgets/background_widget.dart';
import 'package:task_manager_application/presentation/widgets/profile_bar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEC = TextEditingController();
  final TextEditingController _descriptionTEC = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileBar,
      body: BackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 48,),
                Text('Add New Task', style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 24
                ),),
                SizedBox(height: 16,),
                TextFormField(
                  controller: _titleTEC,
                  decoration: InputDecoration(
                    hintText: 'Title',
                  ),
                ),
                SizedBox(height: 8,),
                TextFormField(
                  controller: _descriptionTEC,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: 'Description',
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
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleTEC.dispose();
    _descriptionTEC.dispose();
  }
}

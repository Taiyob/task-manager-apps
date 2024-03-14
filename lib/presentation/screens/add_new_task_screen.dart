import 'package:flutter/material.dart';
import 'package:task_manager_application/data/services/network_caller.dart';
import 'package:task_manager_application/data/utilities/urls.dart';
import 'package:task_manager_application/presentation/widgets/background_widget.dart';
import 'package:task_manager_application/presentation/widgets/profile_bar.dart';
import 'package:task_manager_application/presentation/widgets/snack_bar_message_widget.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEC = TextEditingController();
  final TextEditingController _descriptionTEC = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _addNewTaskInprogress = false;
  bool _shouldRefreshNewTaskList = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Navigator.pop(context, _shouldRefreshNewTaskList);
        return false;
      },
      child: Scaffold(
        appBar: profileBar,
        body: BackgroundWidget(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 48,),
                    Text('Add New Task', style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 24
                    ),),
                    const SizedBox(height: 16,),
                    TextFormField(
                      controller: _titleTEC,
                      decoration: const InputDecoration(
                        hintText: 'Title',
                      ),
                      validator: (String? value){
                        if(value?.trim().isEmpty ?? true){
                          return 'Title must be required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8,),
                    TextFormField(
                      controller: _descriptionTEC,
                      maxLines: 6,
                      decoration: const InputDecoration(
                        hintText: 'Description',
                      ),
                      validator: (String? value){
                        if(value?.trim().isEmpty ?? true){
                          return 'Description must be required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16,),
                    SizedBox(width: double.infinity, child: Visibility(
                      visible: _addNewTaskInprogress == false,
                      replacement: const Center(child: CircularProgressIndicator()),
                      child: ElevatedButton(onPressed: (){
                        if(_formKey.currentState!.validate()){
                          _addNewTask();
                        }
                      }, child: const Icon(Icons.arrow_circle_right_outlined)),
                    )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  Future<void> _addNewTask() async{
    _addNewTaskInprogress = true;
    setState(() {});
    Map<String, dynamic> inPutParams = {
      "title" : _titleTEC.text.trim(),
      "description" : _descriptionTEC.text.trim(),
      "status" : "New",
    };
    final response = await NetworkCaller.postRequest(Urls.createTask, inPutParams);
    _addNewTaskInprogress = false;
    setState(() {});
    if(response.isSuccess){
      _shouldRefreshNewTaskList = true;
      _titleTEC.clear();
      _descriptionTEC.clear();
      if(mounted){
        showSnackBarMessageWidget(context, "New Task has been added");
      }
    }else{
      if(mounted){
        showSnackBarMessageWidget(context, response.errorMessage ?? 'Add new task failed', true);
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleTEC.dispose();
    _descriptionTEC.dispose();
  }
}

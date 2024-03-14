import 'package:flutter/material.dart';
import 'package:task_manager_application/data/models/task_list_wrapper.dart';
import 'package:task_manager_application/presentation/widgets/profile_bar.dart';
import 'package:task_manager_application/presentation/widgets/snack_bar_message_widget.dart';
import 'package:task_manager_application/presentation/widgets/task_card.dart';

import '../../data/services/network_caller.dart';
import '../../data/utilities/urls.dart';
import 'background_widget.dart';
import 'empty_list_widget.dart';

class CompleteTaskScreen extends StatefulWidget {
  const CompleteTaskScreen({super.key});

  @override
  State<CompleteTaskScreen> createState() => _CompleteTaskScreenState();
}

class _CompleteTaskScreenState extends State<CompleteTaskScreen> {
  bool _getCompletedTaskListInprogress = false;
  TaskListWrapper _completedTaskListWrapper = TaskListWrapper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAllCompletedTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileBar,
      body: BackgroundWidget(
        child: Visibility(
          visible: _getCompletedTaskListInprogress == false,
          replacement: const Center(child: CircularProgressIndicator()),
          child: RefreshIndicator(
            onRefresh: ()async{
              _getAllCompletedTaskList();
            },
            child: Visibility(
              visible: _completedTaskListWrapper.taskList?.isNotEmpty ?? false,
              replacement: const EmptyListWidget(),
              child: ListView.builder(itemCount: _completedTaskListWrapper.taskList?.length ?? 0, itemBuilder: (context, index){
                return TaskCard(taskItem: _completedTaskListWrapper.taskList![index],refreshList: (){_getAllCompletedTaskList();},);
              },),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getAllCompletedTaskList() async{
    _getCompletedTaskListInprogress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.completedTaskList);
    if(response.isSuccess){
      _completedTaskListWrapper = TaskListWrapper.fromJson(response.responseBody);
      _getCompletedTaskListInprogress = false;
      setState(() {});
    }else{
      _getCompletedTaskListInprogress = false;
      setState(() {});
      if(mounted){
        showSnackBarMessageWidget(context, response.errorMessage ?? "Completed Task list has been failed");
      }
    }
  }
}

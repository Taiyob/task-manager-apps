import 'package:flutter/material.dart';
import 'package:task_manager_application/data/models/task_list_wrapper.dart';
import 'package:task_manager_application/data/services/network_caller.dart';
import 'package:task_manager_application/data/utilities/urls.dart';
import 'package:task_manager_application/presentation/widgets/profile_bar.dart';
import 'package:task_manager_application/presentation/widgets/snack_bar_message_widget.dart';
import 'package:task_manager_application/presentation/widgets/task_card.dart';

import 'background_widget.dart';
import 'empty_list_widget.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  bool _getProgressTaskListInprogress = false;
  TaskListWrapper _progressTaskListWrapper = TaskListWrapper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAllProgressTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileBar,
      body: BackgroundWidget(
        child: Visibility(
          visible: _getProgressTaskListInprogress == false,
          replacement: const Center(child: CircularProgressIndicator()),
          child: RefreshIndicator(
            onRefresh: () async{
              _getAllProgressTaskList();
            },
            child: Visibility(
              visible: _progressTaskListWrapper.taskList?.isNotEmpty ?? false,
              replacement: const EmptyListWidget(),
              child: ListView.builder(itemCount: _progressTaskListWrapper.taskList?.length ?? 0, itemBuilder: (context, index){
                return TaskCard(taskItem: _progressTaskListWrapper.taskList![index], refreshList: (){_getAllProgressTaskList();});
              }),
            ),
          ),
        ),
      ),
    );
  }
//
  Future<void> _getAllProgressTaskList() async{
    _getProgressTaskListInprogress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.progressTaskList);
    if(response.isSuccess){
      _progressTaskListWrapper = TaskListWrapper.fromJson(response.responseBody);
      _getProgressTaskListInprogress = false;
      setState(() {});
    }else{
      _getProgressTaskListInprogress = false;
      setState(() {});
      if(mounted){
        showSnackBarMessageWidget(context, response.errorMessage ?? "Progress Task list has been failed");
      }
    }
  }
}

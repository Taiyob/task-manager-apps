import 'package:flutter/material.dart';
import 'package:task_manager_application/data/services/network_caller.dart';
import 'package:task_manager_application/data/utilities/urls.dart';
import 'package:task_manager_application/presentation/widgets/background_widget.dart';
import 'package:task_manager_application/presentation/widgets/empty_list_widget.dart';
import 'package:task_manager_application/presentation/widgets/profile_bar.dart';
import 'package:task_manager_application/presentation/widgets/snack_bar_message_widget.dart';
import 'package:task_manager_application/presentation/widgets/task_card.dart';

import '../../data/models/task_list_wrapper.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  bool _getCancelTaskListInprogress = false;
  TaskListWrapper _cancelTaskListWrapper = TaskListWrapper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAllCancelTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileBar,
      body: BackgroundWidget(
        child: Visibility(
          visible: _getCancelTaskListInprogress == false,
          replacement: Center(child: CircularProgressIndicator()),
          child: RefreshIndicator(
            onRefresh: () async{
              _getAllCancelTaskList();
            },
            child: Visibility(
              visible: _cancelTaskListWrapper.taskList?.isNotEmpty ?? false,
              replacement: EmptyListWidget(),
              child: ListView.builder(itemCount: _cancelTaskListWrapper.taskList?.length ?? 0, itemBuilder: (context, index){
                return TaskCard(taskItem: _cancelTaskListWrapper.taskList![index], refreshList: (){_getAllCancelTaskList();},);
              }),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getAllCancelTaskList() async {
    _getCancelTaskListInprogress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.canceledTaskList);
    if(response.isSuccess){
      _cancelTaskListWrapper = TaskListWrapper.fromJson(response.responseBody);
      _getCancelTaskListInprogress = false;
      setState(() {});
    }else{
      _getCancelTaskListInprogress = false;
      setState(() {});
      if(mounted){
        showSnackBarMessageWidget(context, response.errorMessage ?? "Cancel Task list has been failed");
      }
    }
  }
}

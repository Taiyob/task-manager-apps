import 'package:flutter/material.dart';
import 'package:task_manager_application/data/models/count_by_status_wrapper.dart';
import 'package:task_manager_application/data/models/task_list_wrapper.dart';
import 'package:task_manager_application/data/services/network_caller.dart';
import 'package:task_manager_application/presentation/screens/add_new_task_screen.dart';
import 'package:task_manager_application/presentation/utils/app_colors.dart';
import 'package:task_manager_application/presentation/widgets/background_widget.dart';
import 'package:task_manager_application/presentation/widgets/snack_bar_message_widget.dart';

import '../../data/utilities/urls.dart';
import '../widgets/empty_list_widget.dart';
import '../widgets/profile_bar.dart';
import '../widgets/task_card.dart';
import '../widgets/task_counter_file.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getAllTaskCountByStatusInprogress = false;
  bool _getNewTaskListInprogress = false;
  CountByStatusWrapper _countByStatusWrapper = CountByStatusWrapper();
  TaskListWrapper _taskListWrapper = TaskListWrapper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDataFromApi();
  }

  void _getDataFromApi() {
    _getAllTaskCountByStatus();
    _getAllNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileBar,
      body: BackgroundWidget(
        child: Column(
          children: [
            Visibility(
                visible: _getAllTaskCountByStatusInprogress == false,
                replacement: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: LinearProgressIndicator(),
                ),
                child: taskCounterSection),
            Expanded(
              child: Visibility(
                visible: _getNewTaskListInprogress == false,
                replacement: const Center(child: CircularProgressIndicator()),
                child: RefreshIndicator(
                  onRefresh: () async => _getDataFromApi(),
                  child: Visibility(
                    visible: _taskListWrapper.taskList?.isNotEmpty ?? false,
                    replacement: const EmptyListWidget(),
                    child: ListView.builder(
                      itemCount: _taskListWrapper.taskList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return TaskCard(
                          taskItem: _taskListWrapper.taskList![index],
                          refreshList: () {
                            _getDataFromApi();
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Todo: Recall the home apis after successfully ad new task/tasks
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewTaskScreen(),
            ),
          );
          if (result != null && result == true) {
            _getDataFromApi();
          }
        },
        backgroundColor: AppColors.themeColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget get taskCounterSection {
    return SizedBox(
      height: 110,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemCount: _countByStatusWrapper.listOfTaskByStatusData?.length ?? 0,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return TaskCounterCard(
                amount:
                    _countByStatusWrapper.listOfTaskByStatusData![index].sum ??
                        0,
                title:
                    _countByStatusWrapper.listOfTaskByStatusData![index].sId ??
                        "");
          },
          separatorBuilder: (_, __) {
            return const SizedBox(
              width: 8,
            );
          },
        ),
      ),
    );
  }

  Future<void> _getAllTaskCountByStatus() async {
    _getAllTaskCountByStatusInprogress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.taskStatusCount);
    if (response.isSuccess) {
      _countByStatusWrapper =
          CountByStatusWrapper.fromJson(response.responseBody);
      _getAllTaskCountByStatusInprogress = false;
      setState(() {});
    } else {
      _getAllTaskCountByStatusInprogress = false;
      setState(() {});
      if (mounted) {
        showSnackBarMessageWidget(context,
            response.errorMessage ?? "Task Count By Status has been failed");
      }
    }
  }

  Future<void> _getAllNewTaskList() async {
    _getNewTaskListInprogress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.newTaskList);
    if (response.isSuccess) {
      _taskListWrapper = TaskListWrapper.fromJson(response.responseBody);
      _getNewTaskListInprogress = false;
      setState(() {});
    } else {
      _getNewTaskListInprogress = false;
      setState(() {});
      if (mounted) {
        showSnackBarMessageWidget(
            context, response.errorMessage ?? "Task list has been failed");
      }
    }
  }
}

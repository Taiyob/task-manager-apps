import 'package:flutter/material.dart';
import 'package:task_manager_application/data/models/task_item.dart';
import 'package:task_manager_application/presentation/widgets/snack_bar_message_widget.dart';

import '../../data/services/network_caller.dart';
import '../../data/utilities/urls.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.taskItem,
    required this.refreshList,
  });

  final TaskItem taskItem;
  final VoidCallback refreshList;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _updateTaskStatusInprogress = false;
  bool _deleteTaskInprogress = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.taskItem.title ?? "",style: TextStyle(fontWeight: FontWeight.bold),),
            Text(widget.taskItem.description ?? "",style: TextStyle(),),
            Text('Date ${widget.taskItem.createdDate}',style: TextStyle(),),
            Row(
              children: [
                Chip(label: Text(widget.taskItem.status ?? ""),),
                Spacer(),
                Visibility(
                  visible: _updateTaskStatusInprogress == false,
                  replacement: CircularProgressIndicator(),
                  child: IconButton(onPressed: ()async{
                    _showUpdateStatusDialogue(widget.taskItem.sId!);
                  }, icon: Icon(Icons.edit),),
                ),
                Visibility(
                  visible: _deleteTaskInprogress == false,
                  replacement: CircularProgressIndicator(),
                  child: IconButton(onPressed: ()async{
                    _deleteTaskById(widget.taskItem.sId!);
                  }, icon: Icon(Icons.delete),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showUpdateStatusDialogue(String id){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text('Select Status'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(title: Text('New'),trailing: _isCurrentStatus('New') ? Icon(Icons.check) : null, onTap: (){
              if(_isCurrentStatus('New')){
                return;
              }
              _updateTaskById(id, 'New');
              Navigator.pop(context);
            },),
            ListTile(title: Text('Completed'),trailing: _isCurrentStatus('Completed') ? Icon(Icons.check) : null,onTap: ()async{
              if(_isCurrentStatus('Completed')){
                return;
              }
              _updateTaskById(id, 'Completed');
              Navigator.pop(context);
            }),
            ListTile(title: Text('Progress'),trailing: _isCurrentStatus('Progress') ? Icon(Icons.check) : null,onTap: ()async{
              if(_isCurrentStatus('Progress')){
                return;
              }
              _updateTaskById(id, 'Progress');
              Navigator.pop(context);
            }),
            ListTile(title: Text('Cancelled'),trailing: _isCurrentStatus('Cancelled') ? Icon(Icons.check) : null,onTap: ()async{
              if(_isCurrentStatus('Cancelled')){
                return;
              }
              _updateTaskById(id, 'Cancelled');
              Navigator.pop(context);
            }),
          ],
        ),
      );
    });
  }

  bool _isCurrentStatus(String status) {
    return widget.taskItem.status! == status;
  }

  Future<void> _updateTaskById(String id, String status) async{
    _updateTaskStatusInprogress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.updateTaskList(id,status));
    _updateTaskStatusInprogress = false;
    if(response.isSuccess){
      _updateTaskStatusInprogress = false;
      setState(() {});
      widget.refreshList();
    }else{
      setState(() {});
      if(mounted){
        showSnackBarMessageWidget(context, response.errorMessage ?? "Update task status has been deleted failed");
      }
    }
  }

  Future<void> _deleteTaskById(String id) async{
    _deleteTaskInprogress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.deleteTaskList(id));
    _deleteTaskInprogress = false;
    if(response.isSuccess){
      widget.refreshList();
    }else{
      setState(() {});
      if(mounted){
        showSnackBarMessageWidget(context, response.errorMessage ?? "Task list has been deleted failed");
      }
    }
  }
}
import 'package:flutter/material.dart';
import 'package:task_manager_application/presentation/widgets/background_widget.dart';
import 'package:task_manager_application/presentation/widgets/profile_bar.dart';
import 'package:task_manager_application/presentation/widgets/task_card.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileBar,
      body: BackgroundWidget(
        child: ListView.builder(itemBuilder: (context, index){
          //return TaskCard(taskItem: taskItem);
        }),
      ),
    );
  }
}

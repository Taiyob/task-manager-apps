import 'package:flutter/material.dart';
import 'package:task_manager_application/presentation/widgets/profile_bar.dart';

import 'background_widget.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
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

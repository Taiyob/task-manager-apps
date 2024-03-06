import 'package:flutter/material.dart';
import 'package:task_manager_application/presentation/widgets/profile_bar.dart';
import 'package:task_manager_application/presentation/widgets/task_card.dart';

import 'background_widget.dart';

class CompleteTaskScreen extends StatefulWidget {
  const CompleteTaskScreen({super.key});

  @override
  State<CompleteTaskScreen> createState() => _CompleteTaskScreenState();
}

class _CompleteTaskScreenState extends State<CompleteTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileBar,
      body: BackgroundWidget(
        child: ListView.builder(itemCount: 5, itemBuilder: (context, index){
          return TaskCard();
        },),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
  });

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
            Text('Title',style: TextStyle(fontWeight: FontWeight.bold),),
            Text('Description',style: TextStyle(),),
            Text('Date 03-03-2024',style: TextStyle(),),
            Row(
              children: [
                Chip(label: Text('New'),),
                Spacer(),
                IconButton(onPressed: (){}, icon: Icon(Icons.edit),),
                IconButton(onPressed: (){}, icon: Icon(Icons.delete),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
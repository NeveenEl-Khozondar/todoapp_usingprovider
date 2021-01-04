import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'modelPage.dart';
import 'provider.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  String taskName;
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(20, 50, 20, 20),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => taskName = value,
              decoration: InputDecoration(
                hintText: 'Task subject',
                filled: true,
              ),
              style: TextStyle(fontSize: 30),
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 35),
            Checkbox(
                value: this.isCompleted,
                onChanged: (value) {
                  this.isCompleted = !this.isCompleted;
                  setState(() {});
                }),
            SizedBox(height: 35),
            Container(
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {
                  Provider.of<AppProvider>(context, listen: false)
                      .insertTask(Task(this.taskName, this.isCompleted));
                  Navigator.pop(context);
                },
                child: Text(
                  'Add task',
                  style: TextStyle(fontSize: 24),
                ),
                color: Colors.lightGreenAccent,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.all(15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

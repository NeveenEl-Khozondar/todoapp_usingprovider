import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'modelPage.dart';
import 'provider.dart';

class TaskWidget extends StatefulWidget {
  final Task task;
  final Function function;
  TaskWidget(this.task, [this.function]);

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  showAlertDialog(BuildContext context) {
    Widget noButton = FlatButton(
      child: Text("DELETE"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget yesButton = FlatButton(
      child: Text("OKAY"),
      onPressed: () {
        Provider.of<AppProvider>(context, listen: false)
            .deleteTask(widget.task);
        setState(() {});
        widget.function();
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Dialog"),
      content: Text("Are you sure ?"),
      actions: [noButton, yesButton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                icon: Icon(Icons.delete, color: Colors.black),
                onPressed: () {
                  showAlertDialog(context);
                }),
            Text(widget.task.taskName),
            Checkbox(
                value: widget.task.isCompleted,
                onChanged: (value) {
                  widget.task.isCompleted = !widget.task.isCompleted;
                  Provider.of<AppProvider>(context, listen: false)
                      .updateTask(widget.task);
                  setState(() {});
                  widget.function();
                }),
          ],
        ),
      ),
    );
  }
}

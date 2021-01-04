import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'addTask.dart';
import 'db_helper.dart';
import 'modelPage.dart';
import 'provider.dart';
import 'widgetPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return AppProvider();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}

class BasicPage extends StatefulWidget {
  @override
  _BasicPageState createState() => _BasicPageState();
}

class _BasicPageState extends State<BasicPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('TODO APP'),
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(text: 'Tasks'),
            Tab(text: 'Completed Tasks'),
            Tab(text: 'Incompleted Tasks'),
          ],
          isScrollable: true,
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [AllTasks(), CompletedTasks(), IncompletedTasks()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddTask()));
        },
        backgroundColor: Colors.lightGreenAccent,
        child: Icon(Icons.add),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Consumer<AppProvider>(
      builder: (context, value, child) {
        var tasks = value.getTasksFromDB(DBHelper.dbHelper.getAllTasks(), mFun);
        value.setValue(tasks);
        Future.delayed(Duration.zero, () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => BasicPage(),
          ));
        });
        return Container();
      },
    ));
  }

  void mFun() {
    setState(() {});
  }
}

class AllTasks extends StatefulWidget {
  @override
  _AllTasksState createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount:
            Provider.of<AppProvider>(context, listen: false).getValue().length,
        itemBuilder: (context, index) {
          Task task = Provider.of<AppProvider>(context, listen: false)
              .getValue()[index];
          return TaskWidget(task, fun);
        },
      ),
    );
  }

  void fun() {
    setState(() {});
  }
}

class CompletedTasks extends StatefulWidget {
  @override
  _CompletedTasksState createState() => _CompletedTasksState();
}

class _CompletedTasksState extends State<CompletedTasks> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount:
            Provider.of<AppProvider>(context, listen: false).getValue().length,
        itemBuilder: (context, index) {
          Task task = Provider.of<AppProvider>(context, listen: false)
              .getValue()[index];
          if (task.isCompleted) {
            return TaskWidget(task, fun);
          } else {
            return Container();
          }
        },
      ),
    );
  }

  void fun() {
    setState(() {});
  }
}

class IncompletedTasks extends StatefulWidget {
  @override
  _IncompletedTasksState createState() => _IncompletedTasksState();
}

class _IncompletedTasksState extends State<IncompletedTasks> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount:
            Provider.of<AppProvider>(context, listen: false).getValue().length,
        itemBuilder: (context, index) {
          Task task = Provider.of<AppProvider>(context, listen: false)
              .getValue()[index];
          if (!task.isCompleted) {
            return TaskWidget(task, fun);
          } else {
            return Container();
          }
        },
      ),
    );
  }

  void fun() {
    setState(() {});
  }
}

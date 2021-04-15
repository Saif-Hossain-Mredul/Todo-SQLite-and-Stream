import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app_part1_and_part2/BLoC/app-bloc.dart';
import 'package:my_app_part1_and_part2/screens/addTask.Screen.dart';
import 'package:my_app_part1_and_part2/services/sql/database-helper.service.dart';
import 'package:my_app_part1_and_part2/widgets/task-screen-body.widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final _dataBloc = Provider.of<DataBloc>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 40,
        ),
        onPressed: () {
          Navigator.push(
              context, CupertinoPageRoute(builder: (_) => AddTaskScreen()));
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 5, right: 5, top: 60, bottom: 5),
          // ignore: missing_return
          child: StreamBuilder(
            stream: _dataBloc.taskEvent,
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.none ||
                      snapshot.connectionState == ConnectionState.waiting
                  ? FutureBuilder(
                      future: DatabaseHelper.instance.getTaskList(),
                      builder: (context, snapshot) {
                        return snapshot.hasData
                            ? HomeScreenBody(snapshot: snapshot)
                            : Center(
                                child: Icon(
                                  Icons.list_alt,
                                  color: Colors.blue,
                                  size: 80,
                                ),
                              );
                      },
                    )
                  : HomeScreenBody(snapshot: snapshot);
            },
          ),
        ),
      ),
    );
  }
}

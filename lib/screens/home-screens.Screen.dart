import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:my_app_part1_and_part2/BLoC/app-bloc.dart';
import 'package:my_app_part1_and_part2/screens/addTask.Screen.dart';
import 'package:my_app_part1_and_part2/services/sql/database-helper.service.dart';
import 'package:my_app_part1_and_part2/utilities/bloc-model.utilities.dart';
import 'package:my_app_part1_and_part2/utilities/task-model.utilities.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  getCompletedTaskCount(List tasks) {
    return tasks.where((task) => task.status == 1).toList().length;
  }

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
              context,
              MaterialPageRoute(
                  builder: (_) =>
                      AddTaskScreen()));
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 5, right: 5, top: 60, bottom: 5),
          child: StreamBuilder(
            stream: _dataBloc.taskEvent,

            builder: (context, snapshot) {
              print(snapshot.data);

              return snapshot.hasData
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: Text(
                            'My tasks',
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: Text(
                            '${getCompletedTaskCount(snapshot.data)} of ${snapshot.data.length}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return TaskTile(task: snapshot.data[index], );
                            },
                          ),
                        )
                      ],
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            },
          ),
        ),
      ),
    );
  }
}

class TaskTile extends StatelessWidget {
  final Task task;

  TaskTile({this.task});

  @override
  Widget build(BuildContext context) {
    final _dataBloc = Provider.of<DataBloc>(context);

    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            _dataBloc.eventControllerSink.add(DeleteEvent(task: task));
          },
        ),
      ],
      child: ListTile(
        title: Text(
          '${task.title}',
          style: TextStyle(
              decoration: task.status == 1
                  ? TextDecoration.lineThrough
                  : TextDecoration.none),
        ),
        subtitle: Text(
            '${DateFormat('MMM dd, yyyy').format(task.date)} ⚫ ${task.priority}',style: TextStyle(
            decoration: task.status == 1
                ? TextDecoration.lineThrough
                : TextDecoration.none),),
        trailing: Checkbox(
          value: task.status == 1 ? true : false,
          onChanged: (newVal) {
            task.status = newVal ? 1 : 0;
            _dataBloc.eventControllerSink.add(UpdateEvent(task: task));
          },
        ),
      ),
    );
  }
}

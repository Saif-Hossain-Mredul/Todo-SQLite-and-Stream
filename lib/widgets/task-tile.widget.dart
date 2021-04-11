import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:my_app_part1_and_part2/BLoC/app-bloc.dart';
import 'package:my_app_part1_and_part2/utilities/bloc-model.utilities.dart';
import 'package:my_app_part1_and_part2/utilities/task-model.utilities.dart';
import 'package:provider/provider.dart';

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
          '${DateFormat('MMM dd, yyyy').format(task.date)} ⚫ ${task.priority}',
          style: TextStyle(
              decoration: task.status == 1
                  ? TextDecoration.lineThrough
                  : TextDecoration.none),
        ),
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
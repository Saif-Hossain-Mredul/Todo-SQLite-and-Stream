import 'package:flutter/material.dart';
import 'package:my_app_part1_and_part2/widgets/task-tile.widget.dart';

class TaskScreenBody extends StatelessWidget {
  final AsyncSnapshot snapshot;
  final Function getCompletedTaskCount;

  TaskScreenBody({this.snapshot, this.getCompletedTaskCount});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Text(
            'My tasks',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Text(
            '${getCompletedTaskCount(snapshot.data)} of ${snapshot.data.length}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return TaskTile(
                task: snapshot.data[index],
              );
            },
          ),
        )
      ],
    );
  }
}

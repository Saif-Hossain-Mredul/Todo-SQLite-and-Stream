import 'package:flutter/material.dart';
import 'package:my_app_part1_and_part2/screens/addTask.Screen.dart';
import 'package:my_app_part1_and_part2/services/sql/database-helper.service.dart';
import 'package:my_app_part1_and_part2/utilities/task-model.utilities.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // openAlertDialogue() {
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.all(Radius.circular(16.0))),
  //           contentPadding: EdgeInsets.only(top: 10.0),
  //           content: Container(
  //           ),
  //         );
  //       });
  // }

  Future<List<Task>> _taskList;

  @override
  void initState() {
    _updateTaskList();
    super.initState();
  }

  _updateTaskList() {
    setState(() {
      _taskList = DatabaseHelper.instance.getTaskList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 40,
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddTaskScreen()));
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 5, right: 5, top: 60, bottom: 5),
          child: FutureBuilder(
            future: _taskList,
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
                            '1 of 10',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text('${snapshot.data[index].title}'),
                                subtitle: Text('2 Days ago'),
                                trailing: Checkbox(
                                  value: snapshot.data[index].status == 1
                                      ? true
                                      : false,
                                  onChanged: (newVal) {
                                    
                                  },
                                ),
                              );
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

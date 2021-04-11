import 'package:flutter/material.dart';
import 'package:my_app_part1_and_part2/BLoC/app-bloc.dart';
import 'package:my_app_part1_and_part2/screens/home-screens.Screen.dart';
import 'package:my_app_part1_and_part2/services/sql/database-helper.service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List _tasksList;

  getTasksListAtStart() async {
    _tasksList = await DatabaseHelper.instance.getTaskList();
    print(_tasksList);
  }

  @override
  void initState() {
    getTasksListAtStart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider<DataBloc>(create: (_) => DataBloc())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
      ),
    );
  }
}

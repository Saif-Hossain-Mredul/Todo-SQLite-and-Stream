import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:my_app_part1_and_part2/services/sql/database-helper.service.dart';
import 'file:///F:/Flutter/My%20Works/Todo-SQLite-and-BLoC/lib/BLoC/bloc-model.utilities.dart';

class DataBloc with ChangeNotifier {
  final _dataBase = DatabaseHelper.instance;

  final _eventController = StreamController<BlocEvent>();
  StreamSink<BlocEvent> get eventControllerSink => _eventController.sink;

  final _stateController = StreamController();
  StreamSink get _stateControllerSink => _stateController.sink;
  Stream get taskEvent => _stateController.stream;

  void _eventToState(BlocEvent event) async {
    if (event is InsertEvent) {
      _dataBase.insertTask(event.task);
    } else if (event is UpdateEvent) {
      _dataBase.updateTask(event.task);
    } else if (event is DeleteEvent) {
      _dataBase.deleteTask(event.task.id);
    }

    final taskList = await _dataBase.getTaskList();

    _stateControllerSink.add(taskList);
  }

  DataBloc() {
    _eventController.stream.listen(_eventToState);
  }

  void dispose() {
    _eventController.close();
    _stateController.close();
  }
}

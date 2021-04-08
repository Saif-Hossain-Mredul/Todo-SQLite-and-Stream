class Task {
  int id;
  String title;
  DateTime date;
  String priority;
  int status;

  Task({this.title, this.date, this.priority, this.status});
  Task.withID({this.id, this.title, this.date, this.priority, this.status});

  Map toMap() {
    final map = Map();

    if(id != null) {
      map['id'] = id;
    }

    map['title'] = title;
    map['date'] = date.toIso8601String();
    map['priority'] = priority;
    map['status'] = status;

    return map;
  }

  factory Task.fromMap(Map map) {
    return Task.withID(
        id: map['id'],
        title: map['title'],
        date: DateTime.parse(map['date']),
        priority: map['priority'],
        status: map['status'],
    );
  }
}

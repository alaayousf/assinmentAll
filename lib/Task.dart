import 'Dbhelper.dart';
class Task {
  int idColumntask;
  String taskNameColumntask;
  int taskStateColumntask;

  Task({
    this.idColumntask,
    this.taskNameColumntask,
    this.taskStateColumntask,
  });

  factory Task.formJason(Map<String, dynamic> json) => Task(
    idColumntask: json[Dbhelper.idColumn],
    taskNameColumntask: json[Dbhelper.taskName],
    taskStateColumntask: json[Dbhelper.taskState],
  );


  Map<String, dynamic> toMap() {
    return {
      Dbhelper.taskName: taskNameColumntask,
      Dbhelper.taskState: taskStateColumntask
    };
  }
}

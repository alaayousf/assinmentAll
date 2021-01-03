import 'package:assinment/providerclass2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providerclass2.dart';
import 'Dbhelper.dart';
import 'Task.dart';

class NewTask extends StatefulWidget {
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  var newTasck = '';
  @override
  Widget build(BuildContext context) {
     var info = Provider.of<providerclass2>(context);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: "add new Task",
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.teal)),
                ),
                onChanged: (newValue) {
                  newTasck = newValue;
                },
              ),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () {
                    saveForm(newTasck);
                    //info.setArray(10);
                  },
                ),
              ),
          //Text("data : ${info.list1}")
            ],
          ),
        ),
      ),
    );
  }

  saveForm(String tasks) {
    Task task = Task.formJason({
      Dbhelper.taskName: '$tasks',
      Dbhelper.taskState: 0,
    });
    Dbhelper.dahelper.insertNewRow(task);
  }
}

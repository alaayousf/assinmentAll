import 'package:assinment/providerclass2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Dbhelper.dart';
import 'MyHomePage.dart';
import 'Task.dart';

class tape extends StatefulWidget {
  tape({this.choice});

  final Choice choice;

  @override
  _tapeState createState() => _tapeState();
}

class _tapeState extends State<tape> {
  @override
  Widget build(BuildContext context) {
     var info = Provider.of<providerclass2>(context);

    List<Task> listofTask = [];

    Future<List<Task>> x = widget.choice.titel == 'all tasck'
        ? Dbhelper.dahelper.gretraveData()
        : widget.choice.titel == 'Completed tasck'
            ? Dbhelper.dahelper.getTasckCompleted()
            : Dbhelper.dahelper.getTasckUnCompleted();

    x.then((value) {
      
      info.setArray(value);

    });

    return FutureBuilder(
      future: x,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: info.list1.length,
          itemBuilder: (context, index) {
            widget.choice;
            return _jops(info.list1[index]);
          },
        );
      },
    );
  }

  Row _jops(Task tasck) {
    bool state = tasck.taskStateColumntask == 1 ? true : false;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: IconButton(
            onPressed: () {
              Dbhelper.dahelper.delete(tasck);
              setState(() {});
            },
            icon: Icon(Icons.delete),
          ),
        ),
        Expanded(
          child: Text('${tasck.taskNameColumntask}',
              style: TextStyle(
                fontSize: 20,
              )),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              if (state == true) {
                state = false;
              } else {
                state=true;
              }
            },
            child: CheckboxListTile(
              onChanged: (e) {
                var newupdate=tasck;
                newupdate.taskStateColumntask=state?0:1;
                Dbhelper.dahelper.update(newupdate);
                setState(() {});
              },
              value: state,
            ),
          ),
        )
      ],
    );
  }
}

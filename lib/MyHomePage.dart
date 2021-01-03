
import 'package:flutter/material.dart';
import 'tape.dart';
import 'Dbhelper.dart';
import 'NewTask.dart';
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    Dbhelper.dahelper.initDb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: choice.length,
      child: Scaffold(
        appBar:AppBar(title:Text('SQL'),
        bottom: TabBar(
          isScrollable: true,
          tabs:choice.map<Widget>((Choice e){
            return Tab(
              text: e.titel,
            );
          }).toList(),
        ),),
        body:TabBarView(
          children:choice.map<Widget>((Choice e){
            return tape(choice:e);
          }).toList()
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewTask()),
            );

          },
          child: Center(
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}



class Choice {
  final String titel;
  const Choice({this.titel});
}

const List<Choice> choice = <Choice>[
  Choice(titel: 'all tasck'),
  Choice(titel: 'Completed tasck'),
  Choice(titel: 'unCompleted tasck'),
];



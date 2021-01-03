import 'package:assinment/Task.dart';
import 'package:flutter/material.dart';

class providerclass2 extends ChangeNotifier{

    List<Task> list1;
providerclass2({@required this.list1});

void setArray(List<Task> value) {
  list1=value;
  notifyListeners();
}

}
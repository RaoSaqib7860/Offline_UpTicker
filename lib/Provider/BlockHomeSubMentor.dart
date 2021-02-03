import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BlockHomeSubmentor extends ChangeNotifier {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  List _listOfTask = [];
  List get listOfTask => _listOfTask;
  setTaskList(List data) {
    _listOfTask = data;
  }

  List _boolList = [];
  List get boolList => _boolList;
  setboolList(bool v) {
    _boolList.add(v);
  }

  bool _loading = false;
  bool get loading => _loading;
  setLodingList(bool value) {
    _loading = value;
    notifyListeners();
  }
}

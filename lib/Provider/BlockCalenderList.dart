import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlockCalenderList extends ChangeNotifier {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  List _listofcal = [];
  List get listofcal => _listofcal;
  setlistofcal(List data) {
    _listofcal = data;
  }

  deleteList(int index) {
    _listofcal.removeAt(index);
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  setloading(bool v) {
    _loading = v;
    notifyListeners();
  }

  bool _google = false;
  bool get google => _google;
  setgoogle(bool v) {
    _google = v;
  }

  bool _outlook = false;
  bool get outlook => _outlook;
  setoutlook(bool v) {
    _outlook = v;
  }
}

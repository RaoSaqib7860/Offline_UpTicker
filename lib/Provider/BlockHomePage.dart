import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlockHomePage extends ChangeNotifier {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  List _firstIds = [77, 119, 120, 3, 100, 81, 142, 141, 59, 143, 145, 144, 65];
  List get firstIds => _firstIds;

  bool _isloading = false;
  bool get isloading => _isloading;
  setisloading(bool v) {
    _isloading = v;
    notifyListeners();
  }

  bool _isanim = false;
  bool get isanim => _isanim;
  setisanim(bool v) {
    _isanim = v;
    notifyListeners();
  }

  List _listOfTask = [];
  List get listOfTask => _listOfTask;
  setTaskList(List data) {
    _listOfTask = data;
  }

  String _token;
  String get token => _token;
  setToken(String token) {
    _token = token;
  }

  bool _loading = false;
  bool get loading => _loading;
  setLodingList(bool value) {
    _loading = value;
    notifyListeners();
  }

  List _listSelectedId = [];
  List get listSelectedId => _listSelectedId;

  addSelectedID(String value) {
    if (_listSelectedId.contains(value)) {
    } else {
      _listSelectedId.add(value);
    }
  }

  removeSelectedID(String value) {
    _listSelectedId.remove(value);
  }

  List<List> _dataList = [];
  List<List> get finalDataList => _dataList;

  List<List> _booldataList = [];
  List<List> get finalboolList => _booldataList;

  seprationList() {
    int k = 2;
    List boolData = [];
    List addData = [];

    bool adding = false;

    for (var i = 0; i < _listOfTask.length; i++) {
      if (i <= k) {
        addData.add(_listOfTask[i]);
        boolData.add(false);
        if (i == k) {
          _dataList.add(addData.toList());
          _booldataList.add(boolData.toList());
          if (adding == false) {
            k = k + 4;
            adding = true;
          } else {
            k = k + 3;
            adding = false;
          }
          addData.clear();
          boolData.clear();
        } else if (i == _listOfTask.length - 1) {
          _dataList.add(addData.toList());
          _booldataList.add(boolData.toList());
        }
      }
    }
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/books/v1.dart';

class BlockMantorSelection extends ChangeNotifier {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  bool _userProfile;
  bool get userProfile => _userProfile;
  setUserProfile(bool val) {
    _userProfile = val;
  }

  List _listOfTask = [];
  List get listOfTask => _listOfTask;
  setTaskList(List data) {
    _listOfTask = data;
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

  bool _isskip = false;
  bool get isskip => _isskip;
  setisSKip(bool v) {
    _isskip = v;
    notifyListeners();
  }

  bool _apiCall = false;
  bool get apicall => _apiCall;
  setAPiCall(bool v) {
    _apiCall = v;
    notifyListeners();
  }
}

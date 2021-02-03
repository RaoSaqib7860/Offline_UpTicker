import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlockUserGenderSelection extends ChangeNotifier {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  bool _apiCall = false;
  bool get apiCall => _apiCall;
  setapiCall(bool v) {
    _apiCall = v;
    notifyListeners();
  }

  bool _isforward = false;
  bool get isforward => _isforward;
  setisforward(bool v) {
    _isforward = v;
    notifyListeners();
  }

  String _gender = 'Male';
  String get gender => _gender;
  setGneder(String val) {
    _gender = val;
    notifyListeners();
  }

  String _date = 'Date of Birth';
  String get date => _date;
  setDate(String data) {
    _date = data;
    notifyListeners();
  }

  String _uploaddate = 'Select';
  String get uploaddate => _uploaddate;
  setuploaddate(String data) {
    _uploaddate = data;
    notifyListeners();
  }

  List _list = [true, false, false];
  List get list => _list;
  List _listindex = [0, 1, 2];
  List get listindex => _listindex;
  List _listgender = ['Male', 'Female', 'Non-Binary'];
  List get listgender => _listgender;
}

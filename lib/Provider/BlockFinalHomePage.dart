import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:upticker/Pages/FinalHomePage.dart';

class BlockFinalHomePage extends ChangeNotifier {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  bool _ishint = false;
  bool get ishint => _ishint;
  setishint(bool v) {
    _ishint = v;
    notifyListeners();
  }

  bool _iscompleteTask = false;
  bool get iscompleteTask => _iscompleteTask;
  setiscompleteTask(bool v) {
    _iscompleteTask = v;
    notifyListeners();
  }

  bool _isundo = false;
  bool get isundo => _isundo;
  setisundo(bool v) {
    _isundo = v;
    notifyListeners();
  }

  bool _isredo = false;
  bool get isredo => _isredo;
  setisredo(bool v) {
    _isredo = v;
    notifyListeners();
  }

  double _totalUnCompletedTask = 0.0;
  double get totalUnCompletedTask => _totalUnCompletedTask;
  settotalUnCompletedTask(v) {
    _totalUnCompletedTask = _totalUnCompletedTask + v;
  }

  setSubtotalUnCompletedTask(v) {
    _totalUnCompletedTask = _totalUnCompletedTask - v;
  }

  setminimizetotalUnCompletedTask() {
    _totalUnCompletedTask = 0;
  }

  bool _isCompletedAll = false;
  bool get isCompletedAll => _isCompletedAll;
  setisCompletedAll(bool v) {
    _isCompletedAll = v;
    notifyListeners();
  }

  bool _changeColor = false;
  bool get changeColor => _changeColor;
  setChangeColor(bool v) {
    _changeColor = v;
    notifyListeners();
  }

  List _listOfCheck = [];
  List get listOfCheck => _listOfCheck;
  setlistOfCheck(int index) {
    _listOfCheck[index] = true;
    notifyListeners();
  }

  setlistOfCheckfalse(int index) {
    _listOfCheck[index] = false;
    notifyListeners();
  }

  removelistOfChecks(int index) {
    _listOfCheck.removeAt(index);
    notifyListeners();
  }

  undorecord(var data) {
    _finallist.add(data);
    _finallist.sort((a, b) => a['order'].compareTo(b['order']));
    notifyListeners();
  }

  bool _task = true;
  bool get task => _task;
  settask(bool v) {
    _task = v;
    notifyListeners();
  }

  bool _anim = true;
  bool get anim => _anim;
  setAnim(bool v) {
    _anim = v;
    notifyListeners();
  }

  removeFinalListIndex(int index) {
    _finallist.removeAt(index);
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool isload) {
    if (isload == true) {
      _loading = true;
    } else {
      _loading = false;
    }
    notifyListeners();
  }

  int _day = 0;
  int get day => _day;
  setAddingDay() {
    _day++;
  }

  setminimizeDay() {
    _day--;
  }

  setdays(int day) {
    _day = day;
  }

  getforwardDate() {
    var today = new DateTime.now();
    var fiftyDaysFromNow = today.add(new Duration(days: _day));
    var uploadedformatedDate =
        DateFormat("yyyy-MM-dd").format(fiftyDaysFromNow);
    setUploadedFormat(uploadedformatedDate);
    var newDt = DateFormat.yMMMEd().format(fiftyDaysFromNow);
    _date = newDt;
    FinalHomePageClass.viewdate = newDt;
    notifyListeners();
  }

  getMinimizeDate() {
    var today = new DateTime.now();
    var fiftyDaysFromNow = today.add(new Duration(days: _day));
    var newdate = fiftyDaysFromNow.subtract(new Duration(days: 1));
    _day--;
    var uploadedformatedDate = DateFormat("yyyy-MM-dd").format(newdate);
    setUploadedFormat(uploadedformatedDate);
    var newDt = DateFormat.yMMMEd().format(newdate);
    _date = newDt;
    FinalHomePageClass.viewdate = newDt;
    notifyListeners();
  }

  List _finallist = [];
  List get finalList => _finallist;
  setFinalList(List list) {
    _finallist = list;
  }

  String _date = '';
  String get date => _date;
  setData(String value) {
    _date = value;
    FinalHomePageClass.viewdate = _date;
  }

  String _token = '';
  String get token => _token;
  settoken(String value) {
    _token = value;
  }

  getCurrentDate() {
    var date = new DateTime.now();
    var newDt = DateFormat.yMMMEd().format(date);
    setData(newDt.toString());
  }

  String _uploadedFormatDate = '';
  String get uploadedFormatDate => _uploadedFormatDate;
  setUploadedFormat(String date) {
    _uploadedFormatDate = date;
  }

  double _focustotalPoint = 0.0;
  double get focusTotalPoint => _focustotalPoint;
  iniFocuseTotalPoit() {
    _focustotalPoint = 0.0;
    notifyListeners();
  }

  setfocustotalPoint(i) {
    _focustotalPoint = (_focustotalPoint + i).toDouble();
  }

  minimizefocustotalPoint(i) {
    _focustotalPoint = (_focustotalPoint - i).toDouble();
  }

  double _focusCompletePoint = 0.0;
  double get focusCompletePoint => _focusCompletePoint;
  iniFocausCompletePoint() {
    _focusCompletePoint = 0.0;
    notifyListeners();
  }

  setfocusCompletePoint(i) {
    _focusCompletePoint = (_focusCompletePoint + i).toDouble();
  }

  addmorFocusConpletePoint(value) {
    _focusCompletePoint = (_focusCompletePoint + value).toDouble();
  }

  minimizeFocusConpletePoint(value) {
    _focusCompletePoint = (_focusCompletePoint - value).toDouble();
  }

  double _taskPercentage;
  double get taskPercentage => _taskPercentage;
  settaskPercentage() {
    print('complete Point=$_focusCompletePoint');
    print('total Point=$_focustotalPoint');
    _taskPercentage = (_focusCompletePoint / _focustotalPoint).toDouble();
  }

  double _textPercentage = 0.1;
  double get textPercentage => _textPercentage;
  settextPercentage() {
    _textPercentage = (_taskPercentage * 100).toDouble();
    notifyListeners();
  }

  List<List<String>> _colordata;
  List<List<String>> get colordata => _colordata;
  setColorList(List list) {
    _colordata.add(list);
  }

  List _updatedList = <dynamic>[];
  List get updatedList => _updatedList;
  setreArangelist({int oldindex, int newindex, String event}) {
    _updatedList.clear();
    var data = _finallist[oldindex];
    _finallist.removeAt(oldindex);
    _finallist.insert(newindex, data);
    _finallist.asMap().forEach((index, element) {
      _updatedList.add({
        "id": element['id'],
        "order": index,
        "recurring": event == '1' ? false : true
      });
    });
    print('update task is = $_updatedList');
  }

  setSortingData() {
    List list = [
      {'a': 5},
      {'a': 4},
      {'a': 1}
    ];
    list.sort((a, b) => a['a'].compareTo(b['a']));
    print('sorted list = $list');
  }
  // List _listofStartTime = [];
  // List get listofStartTime => _listofStartTime;
  // setListOfStartTime(String l) {
  //   _listofStartTime.add(l);
  // }

  // List _listofendTime = [];
  // List get listofendTime => _listofendTime;
  // setlistofendTime(String l) {
  //   _listofendTime.add(l);
  // }

  // Slidable Work ..................................

}

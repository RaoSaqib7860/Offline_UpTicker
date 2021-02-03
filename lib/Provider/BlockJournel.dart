import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BlockJournal extends ChangeNotifier {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  bool _update = false;
  bool get update => _update;
  setupdate(bool v) {
    _update = v;
    notifyListeners();
  }

  List _day = [];
  List get day => _day;
  setDay(String value){
    List l = value.split(',');
    print('$l');
    _day.add(l[0]);
    if (_update == true) {
      notifyListeners();
    }
  }

  List _date = [];
  List get date => _date;
  setData(
    String value,
  ) {
    List l = value.split(',');
    _date.add(l[1]);
    if (_update == true) {
      notifyListeners();
    }
  }

  List _serverFormatdate = [];
  List get serverFormatdate => _serverFormatdate;
  setserverFormatdate(String value) {
    List l = value.split(' ');
    _serverFormatdate.add(l[0]);
    if (_update == true) {
      notifyListeners();
    }
  }

  replaceDate() {
    _date.clear();
    _serverFormatdate.clear();
  }

  getCurrentDate(DateTime datetime) {
    var date = datetime;
    print('objectdate =$date');
    setserverFormatdate(date.toString());
    var newdate1 = date.subtract(new Duration(days: 1));
    setserverFormatdate(newdate1.toString());
    var newdate2 = date.subtract(new Duration(days: 2));
    setserverFormatdate(newdate2.toString());
    var newdate3 = date.subtract(new Duration(days: 3));
    setserverFormatdate(newdate3.toString());
    var newdate4 = date.subtract(new Duration(days: 4));
    setserverFormatdate(newdate4.toString());

    var newDt = DateFormat.yMMMEd().format(date);
    print('$newDt');
    setData(newDt.toString());
    setDay(newDt.toString());

    var newDt1 = DateFormat.yMMMEd().format(newdate1);
    print('$newDt1');
    setData(newDt1.toString());
    setDay(newDt1.toString());

    var newDt2 = DateFormat.yMMMEd().format(newdate2);
    setData(newDt2.toString());
    setDay(newDt2.toString());

    var newDt3 = DateFormat.yMMMEd().format(newdate3);
    setData(newDt3.toString());
    setDay(newDt3.toString());

    var newDt4 = DateFormat.yMMMEd().format(newdate4);
    setData(newDt4.toString());
    setDay(newDt4.toString());
  }
}

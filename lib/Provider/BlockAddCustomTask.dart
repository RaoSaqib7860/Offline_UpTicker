import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:upticker/ColorsThems/ThemesColors.dart';

class BlockAddCustomTask extends ChangeNotifier {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  TextEditingController _tasname = TextEditingController();
  TextEditingController get tasname => _tasname;

  TextEditingController _discription = TextEditingController();
  TextEditingController get discription => _discription;
  String _startTime = '';
  String get startTime => _startTime;
  setStartTime(String val) {
    _startTime = val;
    notifyListeners();
  }

  String _endTime = '';
  String get endTime => _endTime;
  setendTime(String val) {
    _endTime = val;
    notifyListeners();
  }

  double _point = 1.0;
  double get point => _point;
  setpoint(double val) {
    _point = val;
    notifyListeners();
  }

  bool _focus = false;
  bool get focus => _focus;
  setfocus(bool val) {
    _focus = val;
    notifyListeners();
  }

  bool _badHabit = false;
  bool get badHabit => _badHabit;
  setBadHabit(bool val) {
    _badHabit = val;
    notifyListeners();
  }

  bool _pintask = false;
  bool get pintask => _pintask;
  setpintask(bool val) {
    _pintask = val;
    notifyListeners();
  }

  bool _fiveminBefore = true;
  bool get fiveminBefore => _fiveminBefore;
  set5minBefore(bool val) {
    _fiveminBefore = val;
    notifyListeners();
  }

  bool _fiveSecBefore = true;
  bool get fiveSecBefore => _fiveSecBefore;
  set5SecBefore(bool val) {
    _fiveSecBefore = val;
    notifyListeners();
  }

  String _colorString = '244, 81, 30';
  String get colorString => _colorString;
  setColorString(String val) {
    _colorString = val;
  }

  setColor(String color) {
    setColorString(color);
    notifyListeners();
  }

  setintialData() {
    var date = DateTime.now();
    _startTime = '${date.hour}:${date.minute}:${date.second}';
    _endTime = '${date.hour}:${date.minute + 5}:${date.second}';
  }

  List _listofBucket = [];
  List get listofBucket => _listofBucket;
  setListOfBucket(List list) {
    _listofBucket = list;
    notifyListeners();
  }

  List _listofSubBucket = [];
  List get listofSubBucket => _listofSubBucket;
  setlistofSubBucket(List list) {
    _listofSubBucket = list;
    notifyListeners();
  }

  bool _isShowBuckets = false;
  bool get isShowBuckets => _isShowBuckets;
  setisShowBucket(bool v) {
    _isShowBuckets = v;
    notifyListeners();
  }

  bool _isShowSubBuckets = false;
  bool get isShowSubBuckets => _isShowSubBuckets;
  setisShowSubBuckets(bool v) {
    _isShowSubBuckets = v;
    notifyListeners();
  }

  int _selectedSubid;
  int get selectedSubid => _selectedSubid;
  setselectedSubid(int id) {
    _selectedSubid = id;
    notifyListeners();
  }

  Color _pcolor = ColorsThemes.c1;
  Color get pcolor => _pcolor;
  setPColors(Color c) {
    _pcolor = c;
    notifyListeners();
  }

  List listofColors = [
    ColorsThemes.c1,
    ColorsThemes.c2,
    ColorsThemes.c3,
    ColorsThemes.c4,
    ColorsThemes.c5,
    ColorsThemes.c6,
    ColorsThemes.c8,
    ColorsThemes.c9,
    ColorsThemes.c10,
    ColorsThemes.c11,
    ColorsThemes.c12,
    ColorsThemes.c13,
    ColorsThemes.c14,
    ColorsThemes.c15,
  ];
  List listofColorsbool = [
    true,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  List listOfColorValue = [
    '244, 81, 30',
    '213, 0, 0',
    '245, 191, 37',
    '255, 255, 0',
    '11, 128, 67',
    '3, 255, 0',
    '1, 155, 238',
    '5, 255, 255',
    '63, 80, 161',
    '129, 141, 207',
    '141, 35, 170',
    '230, 124, 115',
    '97, 97, 97',
    '0, 0, 0'
  ];
  setlistofColorsbool(int index, bool v) {
    listofColorsbool[index] = v;
    notifyListeners();
  }

  List listofColorstext = [
    'Orange',
    'Red',
    'Sun',
    'Yellow',
    'Green',
    'Highlight Green',
    'Deep Blue',
    'Baby Blue',
    'Highlight Blue',
    'Lavender',
    'Purple',
    'Peach',
    'Grey',
    'Black',
  ];
}

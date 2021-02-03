import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:upticker/ColorsThems/ThemesColors.dart';

class BlockSettings extends ChangeNotifier {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  TextEditingController _nameCon = TextEditingController();
  TextEditingController get nameCon => _nameCon;

  // Sub Task work.........................................................

  List _serverSubList = [];
  List get serversubList => _serverSubList;
  setServerSubList(List list) {
    _serverSubList = list;
  }

  deleteAllSubTask() {
    _contList.clear();
    notifyListeners();
  }

  deleteselectedSubTask(int index) {
    _contList.removeAt(index);
    notifyListeners();
  }

  List _addTaskList = [];
  List get addTaskList => _addTaskList;

  setAddTaskList() {
    for (var i = 0; i < _contList.length; i++) {
      TextEditingController con = _contList[i];
      _addTaskList.add((con.text).toString());
    }
  }

  List _contList = [];
  List get conlist => _contList;
  setConList(TextEditingController controller) {
    _contList.add(controller);
    notifyListeners();
  }

  List _contUploadedList = [];
  List get contUploadedList => _contUploadedList;
  setConUploadedList(TextEditingController controller) {
    _contUploadedList.add(controller);
  }

  List _serUploadSubList = [];
  List get serverUploadedSubList => _serUploadSubList;
  setSerUploadedSubList() {
    for (var i = 0; i < _contUploadedList.length; i++) {
      TextEditingController con = _contUploadedList[i];
      if (con.text.isNotEmpty) {
        _serUploadSubList.add({'name': '${(con.text).toString()}'});
      }
    }
    print('$_serUploadSubList');
  }

  bool _dbStatus = false;
  bool get dbStatus => _dbStatus;
  setDBStatus(bool v) {
    _dbStatus = v;
  }

  int _conIndex = 0;
  int get conIndex => _conIndex;
  setcontIndex(int val) {
    _conIndex = val;
  }
// Sub Task end ................................................................................

  String _id = '';
  String get id => _id;
  setId(String ids) {
    _id = ids;
  }

  String _token = '';
  String get token => _token;
  settoken(String tokens) {
    _token = tokens;
  }

  bool _edCont1 = false;
  bool get edCont1 => _edCont1;
  setedCont(bool val) {
    // _edCont1
  }

  var _editData;
  get editData => _editData;
  seteditData(var data) {
    _editData = data;
  }

  bool _loading = false;
  bool get loading => _loading;
  setLoading() {
    _loading = true;
    notifyListeners();
  }

// adit data replacing....................................................................................

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

  String _name = '';
  String get name => _name;
  setname(String val) {
    _name = val;
    notifyListeners();
  }

  double _point;
  double get point => _point;
  setpoint(double val) {
    _point = val;
    notifyListeners();
  }

  bool _focus;
  bool get focus => _focus;
  setfocus(bool val) {
    _focus = val;
    notifyListeners();
  }

  bool _badHabit;
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

  bool _animation;
  bool get animation => _animation;
  setAnimation(bool val) {
    _animation = val;
    notifyListeners();
  }

  bool _audio;
  bool get audio => _audio;
  setaudio(bool val) {
    _audio = val;
    notifyListeners();
  }

  bool _fiveminBefore;
  bool get fiveminBefore => _fiveminBefore;
  set5minBefore(bool val) {
    _fiveminBefore = val;
    notifyListeners();
  }

  bool _fiveSecBefore;
  bool get fiveSecBefore => _fiveSecBefore;
  set5SecBefore(bool val) {
    _fiveSecBefore = val;
    notifyListeners();
  }

  String _discription = '';
  String get setDiscription => _discription;
  setDiscriptions(String val) {
    _discription = val;
    notifyListeners();
  }

  String _colorString;
  String get colorString => _colorString;
  setColorString(String val) {
    _colorString = val;
    notifyListeners();
  }

  List _color = [];
  List get color => _color;
  setColor(String color) {
    _color = color.split(',');
    setColorString(color);
    notifyListeners();
  }

  bool _colorChange = false;
  bool get colorChange => _colorChange;
  setColorChange(bool v) {
    _colorChange = v;
    notifyListeners();
  }

  setAllEditData() {
    print('${_editData['color']}');
    setname(_editData['name']);
    setStartTime(_editData['start_time']);
    setendTime(_editData['end_time']);
    setpoint(_editData['point']);
    setfocus(_editData['focus']);
    setBadHabit(_editData['bad_habbit']);
    setAnimation(_editData['animation']);
    setaudio(_editData['audio']);
    set5minBefore(_editData['_5_mins_before']);
    set5SecBefore(_editData['_5_sec_before']);
    setDiscriptions(_editData['description']);
    setColor(_editData['color']);
    setColorString(_editData['color']);
    setpintask(_editData['pin_task']);
  }
  //finish Data replacing...........................................................................................................

  //Add Note Start ........................................................................................................

  List _notserverSubList = [];
  List get notserversubList => _notserverSubList;
  notsetServerSubList(List list) {
    _notserverSubList = list;
  }

  notdeleteAllSubTask() {
    _notcontList.clear();
    notifyListeners();
  }

  notdeleteselectedSubTask(int index) {
    _notcontList.removeAt(index);
    notifyListeners();
  }

  List _notaddTaskList = [];
  List get notaddTaskList => _notaddTaskList;

  notsetAddTaskList() {
    for (var i = 0; i < _notcontList.length; i++) {
      TextEditingController con = _notcontList[i];
      _notaddTaskList.add((con.text).toString());
    }
  }

  List _notcontList = [];
  List get notconlist => _notcontList;
  notsetConList(TextEditingController controller) {
    _notcontList.add(controller);
    notifyListeners();
  }

  List _notcontUploadedList = [];
  List get notcontUploadedList => _notcontUploadedList;
  notsetConUploadedList(TextEditingController controller) {
    _notcontUploadedList.add(controller);
  }

  List _notserUploadSubList = [];
  List get notserverUploadedSubList => _notserUploadSubList;
  notsetSerUploadedSubList() {
    for (var i = 0; i < _notcontUploadedList.length; i++) {
      TextEditingController con = _notcontUploadedList[i];
      if (con.text.isNotEmpty) {
        _notserUploadSubList.add({'name': '${(con.text).toString()}'});
      }
    }
    print('$_serUploadSubList');
  }

  int _notconIndex = 0;
  int get notconIndex => _notconIndex;
  notsetcontIndex(int val) {
    _notconIndex = val;
  }

  Color _pcolor = ColorsThemes.c1;
  Color get pcolor => _pcolor;
  setPColors(Color c) {
    _pcolor = c;
    setColorChange(true);
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

  // Add note end////////////////////////////////////////////////////////////////
  bool _showSystemApps = false;
  bool _onlyLaunchableApps = false;
  displayBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return _ListAppsPagesContent(
              includeSystemApps: _showSystemApps,
              onlyAppsWithLaunchIntent: _onlyLaunchableApps,
              key: GlobalKey());
        });
  }
}

class _ListAppsPagesContent extends StatelessWidget {
  final bool includeSystemApps;
  final bool onlyAppsWithLaunchIntent;

  const _ListAppsPagesContent(
      {Key key,
      this.includeSystemApps: false,
      this.onlyAppsWithLaunchIntent: false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Application>>(
        future: DeviceApps.getInstalledApplications(
            includeAppIcons: true,
            includeSystemApps: includeSystemApps,
            onlyAppsWithLaunchIntent: onlyAppsWithLaunchIntent),
        builder: (BuildContext context, AsyncSnapshot<List<Application>> data) {
          if (data.data == null) {
            return Center(
              child: Container(
                height: 50,
                width: 50,
                child: SpinKitRotatingCircle(
                  itemBuilder: (context, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorsThemes.mailColors,
                      ),
                    );
                  },
                ),
              ),
            );
          } else {
            List<Application> apps = data.data;
            print(apps);
            return Scrollbar(
              child: GridView.count(
                crossAxisCount: 4,
                children: List.generate(apps.length, (index) {
                  Application app = apps[index];
                  print('package name is = ${app.packageName}');
                  return app is ApplicationWithIcon
                      ? InkWell(
                          onTap: () {
                            DeviceApps.openApp(app.packageName);
                            print('package name is == ${app.packageName}');
                          },
                          child: Container(
                            height: 40,
                            padding:
                                EdgeInsets.only(left: 10, right: 10, top: 10),
                            width: 40,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundImage: MemoryImage(app.icon),
                                  backgroundColor: Colors.white,
                                ),
                                Text(
                                  '${app.appName}',
                                  style: TextStyle(fontSize: 8),
                                )
                              ],
                            ),
                          ),
                        )
                      : null;
                }),
              ),
            );
          }
        });
  }
}

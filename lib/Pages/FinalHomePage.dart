import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:upticker/ApiConfig/APiUtil.dart';
import 'package:upticker/ColorsThems/ThemesColors.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:upticker/DBModels/FinalHomePageDataModel.dart';
import 'package:upticker/DataBase/DBClass.dart';
import 'package:upticker/LocalWidget/RedoService.dart';
import 'package:upticker/LocalWidget/UndoService.dart';
import 'package:upticker/Pages/AddTaskSelection.dart';
import 'package:upticker/Pages/DrawerPage.dart';
import 'package:upticker/Pages/Graph.dart';
import 'package:upticker/Pages/GraphSubBucket.dart';
import 'package:upticker/Pages/OnFocasAnimation.dart';
import 'package:upticker/Pages/Settings.dart';
import 'package:upticker/Provider/BlockDrawerPage.dart';
import 'package:upticker/Provider/BlockFinalHomePage.dart';
import 'package:upticker/Provider/BlockSettings.dart';
import 'package:reorderables/reorderables.dart';
import 'package:upticker/Provider/GraphProvider.dart';
import 'package:upticker/Provider/ProviderGraphSubBucket.dart';
import 'package:upticker/ServicesForApp/FireBaseAnalytics.dart';
import 'package:upticker/SharedPreference/SharedPreference.dart';
import 'package:vibration/vibration.dart';

class FinalHomePageClass extends StatefulWidget {
  static bool pending;
  static Map undorecord;
  static List<List> finallist = [];
  static List listofDate = [];
  static int recoveryDate = 0;

  static bool pendingR;
  static Map undorecordR;
  static List<List> finallistR = [];
  static List listofDateR = [];

  static String newdate = '';
  static String viewdate = '';
  static int day = 0;

  FinalHomePageClass({Key key, this.token, this.date, this.taskisComplete})
      : super(key: key);
  final String token;
  final String date;
  final bool taskisComplete;

  @override
  _FinalHomePageClassState createState() => _FinalHomePageClassState();
}

class _FinalHomePageClassState extends State<FinalHomePageClass>
    with WidgetsBindingObserver {
  DateFormat sdf2 = DateFormat("hh.mm aa");
  List<Widget> _rows;
  String one = '1';
  var data;

  void handleSlideAnimationChanged(Animation<double> slideAnimation) {}

  void handleSlideIsOpenChanged(bool isOpen) {}

  SlidableController slidableController;
  List demolist = [
    'Press begin when you want to begin a task',
    'Press complete once you have completed task',
    'Swipe to Delete, Edit tasks or View Data'
  ];

  @override
  void initState() {
    slidableController = SlidableController(
      onSlideAnimationChanged: handleSlideAnimationChanged,
      onSlideIsOpenChanged: handleSlideIsOpenChanged,
    );
    WidgetsBinding.instance.addObserver(this);
    final BlockFinalHomePage _provider =
        Provider.of<BlockFinalHomePage>(context, listen: false);
    if (widget.taskisComplete == true) {
      Future.delayed(Duration(milliseconds: 100), () {
        _provider.settask(true);
        Future.delayed(Duration(milliseconds: 200), () {
          _provider.setAnim(false);
        });
        Future.delayed(Duration(seconds: 3), () {
          _provider.settask(false);
          _provider.setAnim(true);
        });
      });
    }
    _provider.settoken(widget.token);
    if (FinalHomePageClass.viewdate == '') {
      _provider.getCurrentDate();
    }
    chekDBStatus(_provider);
    sethint(_provider);
    FireBaseAnalyticsServices.setCurrentScreen(
        screenName: 'Home Page', screenClass: 'Home Page class');
    super.initState();
  }

  sethint(BlockFinalHomePage provider) async {
    Future<String> inapp = SharedPreferenceClass.getInApp();
    inapp.then((value) => {
          if (value == null)
            {
              Future.delayed(Duration(milliseconds: 500), () {
                provider.setishint(true);
              }),
              SharedPreferenceClass.addUserInapp('true'),
            }
        });
  }

  // void addTime() {
  //   DateFormat dateFormat = new DateFormat.Hms();
  //   String t1 = "15:55:31";
  //   DateTime open = dateFormat.parse(t1);
  //   final time = open.add(Duration(hours: 0, minutes: 3, seconds: 2));
  //   print('${time.hour}:${time.minute}:${time.second}');
  // }

  // void timedifference() {
  //   DateFormat dateFormat = new DateFormat.Hms();
  //   String t1 = "15:55:31";
  //   String t2 = "15:58:33";
  //   DateTime open = dateFormat.parse(t2);
  //   DateTime close = dateFormat.parse(t1);
  //   final difinSec = open.difference(close).inSeconds;
  //   final difinMin = open.difference(close).inMinutes;
  //   final difinHours = open.difference(close).inHours;
  //   print('Format is = $difinHours:$difinMin:$difinSec');
  // }

  // void maindo() {
  //   DateFormat dateFormat = new DateFormat.Hms();

  //   List products = ["07:00:00", "09:00:00", "11:00:00", "17:00:00"];
  //   List products2 = ["08:00:00", "10:00:00", "13:00:00", "19:00:00"];

  //   String rO1 = "13:00:00";
  //   String rO2 = "14:00:00";

  //   List end = rO2.split(':');
  //   List start = rO1.split(':');

  //   final difinHours = (int.parse(end[0]) - int.parse(start[0])).toString();
  //   final difinMin = (int.parse(end[1]) - int.parse(start[1])).toString();
  //   final difinSec = (int.parse(end[2]) - int.parse(start[2])).toString();

  //   final difinHourss = difinHours.length > 1 ? difinHours : '0$difinHours';
  //   final difinMins = difinMin.length > 1 ? difinMin : '0$difinMin';
  //   final difinSecs = difinSec.length > 1 ? difinSec : '0$difinSec';

  //   print('Format is =  $difinHourss:$difinMins:$difinSecs');
  // }
  // // List newProducts = [];
  // // for (int i = 0; i < 5; i++) {
  // //   newProducts.add(products[i]);
  // // }
  // // newProducts.sort((a, b) => a.compareTo(b));

  // // for (int i = 0; i < 5; i++) {
  // //   print(newProducts[i]);
  // // }
  chekDBStatus(BlockFinalHomePage provider) async {
    getApiDate(provider);
    // List list1;
    // list1 = await DBProvider.instance.getAllfinalHomePageDataRecord();
    // print('$list1');
    // if (list1.length > 0) {
    //   print('this is database ');
    //   provider.setFinalList(list1);
    //   provider.setLoading(true);
    // } else {
    //   print('this is api data ');
    //   getApiDate(provider);
    // }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final BlockFinalHomePage _provider =
        Provider.of<BlockFinalHomePage>(context, listen: false);
    _rows = List<Widget>.generate(
      _provider.finalList.length,
      (int index) {
        _provider.listOfCheck.add(false);
        String s = _provider.finalList[index]['color'];
        List l = s.split(',');
        return Slidable(
          key: ValueKey(index),
          controller: slidableController,
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 1,
          fastThreshold: 1,
          showAllActionsThreshold: 1,
          closeOnScroll: true,
          enabled: _provider.finalList[index]['owner'] == 'outlook' ||
                  _provider.finalList[index]['owner'] == 'google'
              ? false
              : true,
          child: (_provider.finalList[index]['completed'] == true &&
                      _provider.finalList[index]['pin_task'] == false) ||
                  _provider.finalList[index]['missed'] == true
              ? SizedBox()
              : Container(
                  height: height / 20,
                  width: width,
                  margin: EdgeInsets.only(
                      bottom: _provider.finalList[index]['owner'] ==
                                  'outlook' ||
                              _provider.finalList[index]['owner'] == 'google'
                          ? 5
                          : 0),
                  decoration: BoxDecoration(
                      color: _provider.finalList[index]['owner'] == 'outlook' ||
                              _provider.finalList[index]['owner'] == 'google'
                          ? Colors.blueGrey[100]
                          : _provider.finalList[index]['pin_task'] == true
                              ? Colors.yellow[100]
                              : Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.dehaze,
                            size: 23,
                            color: ColorsThemes.mailColors,
                          ),
                          SizedBox(width: width / 25),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: width / 2,
                                child: Text(
                                  '${_provider.finalList[index]['name']}',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                              SizedBox(height: height / 200),
                              Text(
                                '${sdf2.format(DateFormat('Hms').parse(_provider.finalList[index]['start_time']))} - ${sdf2.format(DateFormat('Hms').parse(_provider.finalList[index]['end_time']))}',
                                style: TextStyle(
                                    fontSize: 9,
                                    letterSpacing: 0.2,
                                    color: ColorsThemes.mailColors),
                              ),
                            ],
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                      ),
                      Row(
                        children: [
                          _provider.finalList[index]['focus'] == false
                              ? SizedBox(
                                  height: height / 25,
                                  width: width / 4.5,
                                )
                              : InkWell(
                                  splashColor: Colors.white,
                                  highlightColor: Colors.white,
                                  onTap: () {
                                    print(
                                        'carasol text is = ${_provider.finalList[index]['carousel_text']}');
                                    if (_provider.finalList[index]
                                            ['completed'] ==
                                        false) {
                                      DateFormat dateFormat =
                                          new DateFormat.Hms();
                                      String t1 =
                                          '${_provider.finalList[index]['start_time']}';
                                      String t2 =
                                          "${_provider.finalList[index]['end_time']}";
                                      DateTime open = dateFormat.parse(t2);
                                      DateTime close = dateFormat.parse(t1);
                                      var difinMin =
                                          open.difference(close).inMinutes;
                                      if (difinMin < 0) {
                                        DateTime dateMax =
                                            dateFormat.parse("24:00:00");
                                        DateTime dateMin =
                                            dateFormat.parse("00:00:00");
                                        var difinMin2 =
                                            dateMax.difference(close).inMinutes;
                                        var difinMin3 =
                                            open.difference(dateMin).inMinutes;
                                        difinMin = difinMin2 + difinMin3;
                                        print('$difinMin');
                                      }
                                      print('$difinMin');
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              duration:
                                                  Duration(milliseconds: 0),
                                              type: PageTransitionType
                                                  .rightToLeft,
                                              child: OnFocusAnimationPage(
                                                carasolList:
                                                    _provider.finalList[index]
                                                        ['carousel_text'],
                                                id: "${_provider.finalList[index]['id']}",
                                                audio:
                                                    "${_provider.finalList[index]['audio_file']}",
                                                animation:
                                                    "${_provider.finalList[index]['animation_file']}",
                                                taskName:
                                                    '${_provider.finalList[index]['name']}',
                                                min: difinMin,
                                              )));
                                    }
                                  },
                                  child: Container(
                                    height: height / 25,
                                    width: width / 4.5,
                                    child: Center(
                                      child: Text(
                                        'Begin',
                                        style: TextStyle(
                                            color: ColorsThemes.mailColors,
                                            fontSize: 13),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(7),
                                        border: Border.all(
                                            color: Colors.black, width: 1)),
                                  ),
                                ),
                          SizedBox(
                            width: width / 30,
                          ),
                          InkWell(
                            splashColor: Colors.white,
                            highlightColor: Colors.white,
                            onTap: () {
                              if (_provider.finalList[index]['pin_task'] ==
                                  false) {
                                if (_provider.iscompleteTask == false) {
                                  _provider.setiscompleteTask(true);
                                  if (_provider.listOfCheck[index] == false)
                                    _provider.setSubtotalUnCompletedTask(
                                        _provider.finalList[index]['point']);
                                  Vibration.vibrate(duration: 500);
                                  _provider.setlistOfCheck(index);
                                  if (_provider.anim == true) {
                                    _provider.setAnim(false);
                                    ApiUtils.gettaskCompleted(
                                        provider: _provider,
                                        id: _provider.finalList[index]['id'],
                                        index: index);
                                    UndoService cc = UndoService(
                                        provider: _provider,
                                        date: '${FinalHomePageClass.viewdate}',
                                        mapdata: _provider.finalList[index]);
                                    cc.addData();
                                    Future.delayed(
                                        Duration(seconds: 1, milliseconds: 200),
                                        () {
                                      double value =
                                          _provider.finalList[index]['point'];
                                      _provider.addmorFocusConpletePoint(value);
                                      _provider.settaskPercentage();
                                      _provider.settextPercentage();
                                      _provider.removeFinalListIndex(index);
                                      _provider.removelistOfChecks(index);
                                      if (_provider.task == true)
                                        _provider.settask(false);
                                      if (_provider.task == false) {
                                        Stream<bool> stream =
                                            Stream<bool>.periodic(
                                          Duration(milliseconds: 300),
                                          (int v) {
                                            if (v == 5) _provider.settask(true);
                                            return v.isEven ? true : false;
                                          },
                                        ).take(6);
                                        stream.listen(
                                          (event) {
                                            _provider.setChangeColor(event);
                                          },
                                        );
                                      }
                                    });
                                  }
                                  if (_provider.anim == false) {
                                    Future.delayed(Duration(seconds: 3), () {
                                      _provider.setAnim(true);
                                      _provider.setiscompleteTask(false);
                                      if (_provider.totalUnCompletedTask < 1) {
                                        _provider.setisCompletedAll(true);
                                      }
                                    });
                                  }
                                }
                              } else {
                                if (_provider.finalList[index]['completed'] ==
                                    false) {
                                  if (_provider.iscompleteTask == false) {
                                    _provider.finalList[index]['completed'] =
                                        true;
                                    _provider.setiscompleteTask(true);
                                    if (_provider.listOfCheck[index] == false)
                                      _provider.setSubtotalUnCompletedTask(
                                          _provider.finalList[index]['point']);
                                    Vibration.vibrate(duration: 500);
                                    _provider.setlistOfCheck(index);
                                    if (_provider.anim == true) {
                                      _provider.setAnim(false);
                                      ApiUtils.gettaskCompleted(
                                          provider: _provider,
                                          id: _provider.finalList[index]['id'],
                                          index: index);
                                      Future.delayed(
                                          Duration(
                                              seconds: 2,
                                              milliseconds: 200), () {
                                        double value =
                                            _provider.finalList[index]['point'];
                                        _provider
                                            .addmorFocusConpletePoint(value);
                                        _provider.settaskPercentage();
                                        _provider.settextPercentage();
                                        _provider.setlistOfCheckfalse(index);
                                        if (_provider.task == true)
                                          _provider.settask(false);
                                        if (_provider.task == false) {
                                          Stream<bool> stream =
                                              Stream<bool>.periodic(
                                            Duration(milliseconds: 300),
                                            (int v) {
                                              if (v == 5)
                                                _provider.settask(true);
                                              return v.isEven ? true : false;
                                            },
                                          ).take(6);
                                          stream.listen(
                                            (event) {
                                              _provider.setChangeColor(event);
                                            },
                                          );
                                        }
                                      });
                                    }
                                    if (_provider.anim == false) {
                                      Future.delayed(Duration(seconds: 3), () {
                                        _provider.setAnim(true);
                                        _provider.setiscompleteTask(false);
                                        if (_provider.totalUnCompletedTask <
                                            1) {
                                          _provider.setisCompletedAll(true);
                                        }
                                      });
                                    }
                                  }
                                } else {
                                  _provider.setiscompleteTask(true);
                                  Vibration.vibrate(duration: 500);
                                  _provider.setlistOfCheck(index);
                                  if (_provider.anim == true) {
                                    _provider.setAnim(false);
                                    Future.delayed(
                                        Duration(seconds: 2, milliseconds: 200),
                                        () {
                                      _provider.setlistOfCheckfalse(index);
                                      if (_provider.task == true)
                                        _provider.settask(false);
                                      if (_provider.task == false) {
                                        Stream<bool> stream =
                                            Stream<bool>.periodic(
                                          Duration(milliseconds: 300),
                                          (int v) {
                                            if (v == 5) _provider.settask(true);
                                            return v.isEven ? true : false;
                                          },
                                        ).take(6);
                                        stream.listen(
                                          (event) {
                                            _provider.setChangeColor(event);
                                          },
                                        );
                                      }
                                    });
                                  }
                                  if (_provider.anim == false) {
                                    Future.delayed(Duration(seconds: 3), () {
                                      _provider.setAnim(true);
                                      _provider.setiscompleteTask(false);
                                      if (_provider.totalUnCompletedTask < 1) {
                                        _provider.setisCompletedAll(true);
                                      }
                                    });
                                  }
                                }
                              }
                            },
                            child: _provider.listOfCheck[index] == true
                                ? Container(
                                    height: height / 30,
                                    width: width / 15,
                                    child: Image.asset(
                                      'assets/right.gif',
                                      fit: BoxFit.cover,
                                    ))
                                : Container(
                                    height: height / 30,
                                    width: width / 15,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color.fromARGB(
                                            255,
                                            int.parse((l[0])),
                                            int.parse((l[1])),
                                            int.parse((l[2]))),
                                        border: Border.all(
                                            width: 1, color: Colors.black)),
                                  ),
                          ),
                        ],
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                ),
          secondaryActions: <Widget>[
            IconSlideAction(
              iconWidget: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    splashColor: Colors.white,
                    highlightColor: Colors.white,
                    onTap: () {
                      if (_provider.finalList[index]['owner'] != 'outlook' ||
                          _provider.finalList[index]['owner'] != 'google') {
                        dailogThisandFolwingEvent(
                            provider: _provider, index: index);
                      }
                    },
                    child: Container(
                      height: height / 25,
                      width: width / 5,
                      child: Center(
                        child: Text(
                          'Delete',
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.white,
                    highlightColor: Colors.white,
                    onTap: () {
                      ApiUtils.missedFinalIDData(
                          id: '${_provider.finalList[index]['id']}',
                          index: index,
                          provider: _provider);
                    },
                    child: Container(
                      height: height / 25,
                      width: width / 5,
                      child: Center(
                        child: Text(
                          'Missed',
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.white,
                    highlightColor: Colors.white,
                    onTap: () {
                      if (_provider.finalList[index]['owner'] != 'outlook' ||
                          _provider.finalList[index]['owner'] != 'google') {
                        Navigator.push(
                            context,
                            PageTransition(
                                duration: Duration(milliseconds: 500),
                                type: PageTransitionType.rightToLeft,
                                child: ChangeNotifierProvider(
                                  create: (_) => BlockSettings(),
                                  child: Settings(
                                    id: '${_provider.finalList[index]['id']}',
                                    token: '${widget.token}',
                                    index: index,
                                  ),
                                )));
                      }
                    },
                    child: Container(
                      height: height / 25,
                      width: width / 5,
                      child: Center(
                        child: Text(
                          'Edit',
                          style: TextStyle(
                              color: ColorsThemes.mailColors, fontSize: 13),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(
                              width: 1, color: ColorsThemes.mailColors)),
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.white,
                    highlightColor: Colors.white,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ChangeNotifierProvider(
                                  create: (_) => GraphSubBucketProvider(),
                                  child: GraphSubBucket(
                                    id: '${_provider.finalList[index]['id']}',
                                  ))));
                    },
                    child: Container(
                      height: height / 25,
                      width: width / 5,
                      child: Center(
                        child: Text(
                          'Data',
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: ColorsThemes.mailColors,
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () => {},
            ),
          ],
        );
      },
    );
    super.didChangeDependencies();
  }

  getApiDate(BlockFinalHomePage _provider) async {
    if (FinalHomePageClass.newdate == '') {
      await ApiUtils.getfinalHomePageData(
          context: context, provider: _provider);
    } else {
      await ApiUtils.getfinalHomePageDataUpdated(
          context: context, provider: _provider);
    }
  }

  Future<bool> onbackPress() async {
    print('object');
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final BlockFinalHomePage _provider =
        Provider.of<BlockFinalHomePage>(context);
    void _onReorder(int oldIndex, int newIndex) {
      // dailogThisandFolwingEvent(
      //   provider: _provider,
      // );
      setState(() {
        Widget row = _rows.removeAt(oldIndex);
        _rows.insert(newIndex, row);
      });
      dailogThisandFolwingEvent(
          provider: _provider,
          isreorder: true,
          newindex: newIndex,
          oldindex: oldIndex);
      // String startTime = _provider.finalList[oldIndex]['start_time'];
      // _provider.listofStartTime.removeAt(oldIndex);
      // _provider.listofStartTime.insert(newIndex, startTime);

      // Future.delayed(Duration(seconds: 1), () {
      //   print('${_provider.listofStartTime}');
      // });
      // print('${_provider.listofStartTime}');
      // print('${_provider.listofendTime}');
      // String startTime = _provider.finalList[oldIndex]['start_time'];
      // String endTime = _provider.finalList[oldIndex]['end_time'];

      // _provider.listofStartTime.removeAt(oldIndex);
      // _provider.listofendTime.removeAt(oldIndex);

      // _provider.listofStartTime.insert(newIndex, startTime);
      // _provider.listofendTime.insert(newIndex, endTime);

      // Future.delayed(Duration(seconds: 1), () {
      //   print('${_provider.listofStartTime}');
      //   print('${_provider.listofendTime}');
      // });
      // DateFormat dateFormat = new DateFormat.Hms();
      // String rO1 = "13:00:00";
      // String rO2 = "14:00:00";
      // List end = rO2.split(':');
      // List start = rO1.split(':');
      // final difinHours = int.parse(end[0]) - int.parse(start[0]);
      // final difinMin = int.parse(end[1]) - int.parse(start[1]);
      // final difinSec = int.parse(end[2]) - int.parse(start[2]);
      // print('Format is =  $difinHours:$difinMin:$difinSec');
    }

    Widget reorderableColumn = IntrinsicWidth(
        child: ReorderableColumn(
      children: _rows,
      onReorder: _onReorder,
    ));

    return WillPopScope(
      onWillPop: () => onbackPress(),
      child: SafeArea(
        child: Scaffold(
          key: _provider.scaffoldKey,
          backgroundColor: Colors.white,
          endDrawer: Drawer(
            child: ChangeNotifierProvider(
              create: (_) => BlockDrawerPage(),
              child: DrawerPage(),
            ),
          ),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(height / 4.7),
            child: AppBar(
              flexibleSpace: AnimatedContainer(
                duration: Duration(milliseconds: 150),
                decoration: BoxDecoration(
                    color: _provider.changeColor == true
                        ? Colors.green
                        : Colors.white),
                margin: EdgeInsets.only(top: height / 100),
                height: height / 4.7,
                child: Column(
                  children: [
                    SizedBox(
                      height: height / 40,
                    ),
                    Container(
                      height: height / 13,
                      width: width,
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: width / 10, right: width / 10),
                            height: double.infinity,
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                FinalHomePageClass.viewdate,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    letterSpacing: 0.3),
                              ),
                            ),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black38, blurRadius: 2)
                                ],
                                color: ColorsThemes.darkThemeColor,
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              splashColor: Colors.white,
                              highlightColor: Colors.white,
                              onTap: () {
                                if (_provider.isCompletedAll == true) {
                                  _provider.setisCompletedAll(false);
                                }
                                if (FinalHomePageClass.recoveryDate > -9) {
                                  _provider.setdays(FinalHomePageClass.day);
                                  _provider.getMinimizeDate();
                                  _provider.setLoading(false);
                                  FinalHomePageClass.recoveryDate =
                                      FinalHomePageClass.recoveryDate - 1;
                                  FinalHomePageClass.newdate =
                                      _provider.uploadedFormatDate;
                                  ApiUtils.getfinalHomePageDataUpdated(
                                      context: context, provider: _provider);
                                  FinalHomePageClass.day = _provider.day;
                                  _provider.listOfCheck.clear();
                                  _provider.setisundo(false);
                                  _provider.setisredo(false);
                                  UndoService cc = UndoService(
                                      date: '${FinalHomePageClass.viewdate}',
                                      provider: _provider);
                                  RedoService bb = RedoService(
                                      date: '${FinalHomePageClass.viewdate}',
                                      provider: _provider);
                                  cc.checkRecord();
                                  bb.checkRecord();
                                } else {
                                  print('Over the date ');
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: width / 20),
                                height: double.infinity,
                                width: width / 6,
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: Platform.isAndroid
                                            ? 0
                                            : width / 100),
                                    child: Icon(
                                      Platform.isAndroid
                                          ? Icons.arrow_back
                                          : Icons.arrow_back_ios,
                                      color: ColorsThemes.darkThemeColor,
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                      color: Colors.blueGrey[300],
                                      blurRadius: 3)
                                ], shape: BoxShape.circle, color: Colors.white),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              splashColor: Colors.white,
                              highlightColor: Colors.white,
                              onTap: () {
                                if (_provider.isCompletedAll == true) {
                                  _provider.setisCompletedAll(false);
                                }
                                _provider.setdays(FinalHomePageClass.day);
                                _provider.setAddingDay();
                                _provider.getforwardDate();
                                _provider.setLoading(false);
                                FinalHomePageClass.recoveryDate =
                                    FinalHomePageClass.recoveryDate + 1;
                                FinalHomePageClass.newdate =
                                    _provider.uploadedFormatDate;
                                ApiUtils.getfinalHomePageDataUpdated(
                                    context: context, provider: _provider);
                                FinalHomePageClass.day = _provider.day;
                                _provider.listOfCheck.clear();
                                _provider.setisundo(false);
                                _provider.setisredo(false);
                                UndoService cc = UndoService(
                                    date: '${FinalHomePageClass.viewdate}',
                                    provider: _provider);
                                RedoService bb = RedoService(
                                    date: '${FinalHomePageClass.viewdate}',
                                    provider: _provider);
                                cc.checkRecord();
                                bb.checkRecord();
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: width / 20),
                                height: double.infinity,
                                width: width / 6,
                                child: Center(
                                  child: Icon(
                                    Platform.isAndroid
                                        ? Icons.arrow_forward
                                        : Icons.arrow_forward_ios,
                                    color: ColorsThemes.darkThemeColor,
                                  ),
                                ),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                      color: Colors.blueGrey[300],
                                      blurRadius: 3)
                                ], shape: BoxShape.circle, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height / 50,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        splashColor: Colors.white,
                        highlightColor: Colors.white,
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  duration: Duration(milliseconds: 300),
                                  type: PageTransitionType.rightToLeft,
                                  child: AddTaskSelection()));
                        },
                        child: ElasticInUp(
                          delay: Duration(seconds: 2),
                          child: Container(
                            margin: EdgeInsets.only(right: width / 30),
                            height: height / 20,
                            width: width / 10,
                            child: Center(
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.blueGrey[300],
                                      blurRadius: 3)
                                ],
                                shape: BoxShape.circle,
                                color: ColorsThemes.darkThemeColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
              ),
              elevation: 0,
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              leading: Container(),
              actions: [Container()],
            ),
          ),
          body: Stack(
            children: [
              AnimatedOpacity(
                duration: Duration(milliseconds: 800),
                opacity: _provider.loading == false ? 0.3 : 1,
                child: AnimatedContainer(
                  height: height,
                  width: width,
                  padding: EdgeInsets.only(
                    top: _provider.loading == false ? height / 9 : 0,
                    left: width / 30,
                    right: width / 30,
                  ),
                  duration: Duration(milliseconds: 1000),
                  curve: Curves.ease,
                  child: _provider.loading == false
                      ? Center(
                          child: Container(
                            height: height / 10,
                            width: width / 5,
                            child: SpinKitRotatingCircle(
                              itemBuilder: (BuildContext context, int index) {
                                return DecoratedBox(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: index.isEven
                                        ? ColorsThemes.mailColors
                                        : ColorsThemes.mailColors,
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.only(bottom: height / 7),
                          child: reorderableColumn,
                        ),
                ),
              ),
              _provider.isCompletedAll == true
                  ? FadeInUp(
                      child: Container(
                        height: height,
                        width: width,
                        padding: EdgeInsets.only(
                            top: height / 10,
                            left: width / 15,
                            right: width / 15),
                        child: Text(
                          'Well done! You have completed todays tasks. Take a break. Consider increasing the tasks goingforward today was very easy, if not stay at it untilgetting 70% becomes easy and then up your tasks.',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 14,
                            textBaseline: TextBaseline.ideographic,
                            letterSpacing: 0.7,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
              Container(
                alignment: Alignment.center,
                height: height,
                width: width,
                margin: EdgeInsets.only(bottom: height / 4),
                child: AnimatedPadding(
                  curve: Curves.ease,
                  onEnd: () {},
                  duration: Duration(seconds: 1),
                  padding: EdgeInsets.all(
                      _provider.anim == true ? height / 1.5 : width / 10),
                  child: Image.asset(
                    ApiUtils.pop_up == 'good'
                        ? 'assets/Good.png'
                        : ApiUtils.pop_up == 'smashed it'
                            ? 'assets/smashedit.png'
                            : ApiUtils.pop_up == 'great'
                                ? 'assets/great.png'
                                : ApiUtils.pop_up == 'stay strong'
                                    ? 'assets/staystrong.png'
                                    : 'assets/Good.png',
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 150),
                  padding: EdgeInsets.only(
                    left: width / 20,
                    right: width / 20,
                  ),
                  width: width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: height / 150),
                        child: Column(
                          children: [
                            _provider.isundo == true
                                ? IconButton(
                                    icon: Icon(
                                      Icons.undo,
                                      color: ColorsThemes.mailColors,
                                    ),
                                    onPressed: () {
                                      UndoService cc = UndoService(
                                        provider: _provider,
                                        date: '${FinalHomePageClass.viewdate}',
                                      );
                                      cc.getData();
                                      Future.delayed(
                                          Duration(milliseconds: 100), () {
                                        if (FinalHomePageClass.pending ==
                                            true) {
                                          print('is pending true');

                                          _provider.settotalUnCompletedTask(
                                              FinalHomePageClass
                                                  .undorecord['point']);
                                          if (_provider.isCompletedAll == true)
                                            _provider.setisCompletedAll(false);
                                          _provider.undorecord(
                                              FinalHomePageClass.undorecord);
                                          _provider.minimizeFocusConpletePoint(
                                              FinalHomePageClass
                                                  .undorecord['point']);
                                          _provider.settaskPercentage();
                                          _provider.settextPercentage();

                                          ApiUtils.gettaskCompletedUndo(
                                            provider: _provider,
                                            id: FinalHomePageClass
                                                .undorecord['id'],
                                          );
                                          print(
                                              'id is =${FinalHomePageClass.undorecord['id']}');
                                          print(
                                              'point is = ${FinalHomePageClass.undorecord['point']}');
                                          print(
                                              'for redo map is = ${FinalHomePageClass.undorecord}');
                                          RedoService cc = RedoService(
                                              provider: _provider,
                                              date:
                                                  '${FinalHomePageClass.viewdate}',
                                              mapdata: FinalHomePageClass
                                                  .undorecord);
                                          cc.addData();
                                        } else {
                                          print('No recent record .');
                                        }
                                      });
                                    })
                                : SizedBox(
                                    width: width / 7.5,
                                    height: height / 15,
                                  ),
                            _provider.isredo == true
                                ? IconButton(
                                    icon: Icon(
                                      Icons.redo,
                                      color: ColorsThemes.mailColors,
                                    ),
                                    onPressed: () {
                                      RedoService cc = RedoService(
                                        provider: _provider,
                                        date: '${FinalHomePageClass.viewdate}',
                                      );
                                      cc.getData();
                                      print('get complete');
                                      Future.delayed(
                                          Duration(milliseconds: 100), () {
                                        if (FinalHomePageClass.pendingR ==
                                            true) {
                                          print('R true get complete');
                                          print(
                                              'id is =${FinalHomePageClass.undorecordR['id']}');
                                          print(
                                              'point is = ${FinalHomePageClass.undorecordR['point']}');
                                          _provider.setSubtotalUnCompletedTask(
                                              FinalHomePageClass
                                                  .undorecordR['point']);
                                          if (_provider.totalUnCompletedTask <
                                              1) {
                                            _provider.setisCompletedAll(true);
                                          }
                                          double value = FinalHomePageClass
                                              .undorecordR['point'];
                                          _provider
                                              .addmorFocusConpletePoint(value);
                                          _provider.settaskPercentage();
                                          _provider.settextPercentage();
                                          int id = FinalHomePageClass
                                              .undorecordR['id'];
                                          print('id is = $id');
                                          _provider.finalList
                                              .forEach((element) {
                                            if (element['id'] == id) {
                                              data = element;
                                            }
                                          });
                                          print(
                                              'trace data is =======================  $data');
                                          int index =
                                              _provider.finalList.indexOf(data);
                                          _provider.removeFinalListIndex(index);
                                          _provider.removelistOfChecks(index);
                                          print('Cretae undo object');
                                          UndoService cc = UndoService(
                                              provider: _provider,
                                              date:
                                                  '${FinalHomePageClass.viewdate}',
                                              mapdata: FinalHomePageClass
                                                  .undorecordR);
                                          cc.addData();
                                          ApiUtils.gettaskCompleted(
                                              provider: _provider,
                                              id: FinalHomePageClass
                                                  .undorecordR['id'],
                                              index: index);
                                        } else {
                                          print('No recent record .');
                                        }
                                      });
                                    })
                                : SizedBox(
                                    width: width / 7.5,
                                    height: height / 15,
                                  )
                          ],
                        ),
                      ),
                      CircularPercentIndicator(
                        radius: 90.0,
                        lineWidth: 3.0,
                        animation: true,
                        percent: _provider.loading == false
                            ? 0.0
                            : _provider.taskPercentage >= 0.0
                                ? _provider.taskPercentage
                                : 0.0,
                        center: InkWell(
                          splashColor: Colors.white,
                          highlightColor: Colors.white,
                          focusColor: Colors.white,
                          hoverColor: Colors.white,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (c) => ChangeNotifierProvider(
                                      create: (_) => GraphProvider(),
                                      child: Graph()),
                                ));
                          },
                          child: AnimatedContainer(
                            height: height / 10,
                            width: width / 5,
                            curve: Curves.bounceOut,
                            margin: EdgeInsets.all(_provider.loading == false
                                ? width / 10
                                : width / 50),
                            child: Center(
                              child: Text(
                                _provider.loading == false
                                    ? ''
                                    : '${(_provider.textPercentage).toStringAsFixed(2)}%',
                                style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 0.3,
                                    fontSize: 12),
                              ),
                            ),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _provider.loading == false
                                    ? Colors.deepPurpleAccent
                                    : ColorsThemes.mailColors),
                            duration: Duration(milliseconds: 500),
                          ),
                        ),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: ColorsThemes.mailColors,
                        backgroundColor: Colors.white,
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.dehaze,
                            color: ColorsThemes.mailColors,
                          ),
                          onPressed: () {
                            _provider.scaffoldKey.currentState.openEndDrawer();
                          })
                    ],
                  ),
                  height: height / 7,
                  decoration: BoxDecoration(
                      color: _provider.changeColor == true
                          ? Colors.green
                          : Colors.white),
                ),
              ),
              _provider.ishint == false
                  ? SizedBox()
                  : Align(
                      alignment: Alignment.bottomRight,
                      child: ZoomIn(
                        duration: Duration(seconds: 2),
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blueGrey[200],
                                borderRadius: BorderRadius.circular(10)),
                            margin: EdgeInsets.only(
                                bottom: height / 7, right: width / 30),
                            height: height / 2,
                            width: width / 1.5,
                            child: Stack(
                              children: [
                                Container(
                                  height: height / 3,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: width / 6, right: width / 6),
                                        child: Image.asset('assets/layer.png',
                                            color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: width / 50,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: width / 3, right: width / 3),
                                        child: Image.asset(
                                          'assets/uptickerLogo.png',
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: width / 50,
                                      ),
                                      Text(
                                        'ALWAYS IMPROVING',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            letterSpacing: 0.3,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: LinearGradient(
                                          colors: [
                                            ColorsThemes.orangeColors,
                                            ColorsThemes.redColors,
                                            ColorsThemes.orangeColors,
                                          ],
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomLeft)),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: InkWell(
                                    onTap: () {
                                      _provider.setishint(false);
                                    },
                                    child: Container(
                                        margin: EdgeInsets.all(width / 22),
                                        padding: EdgeInsets.all(width / 100),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.black),
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 20,
                                        )),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: CarouselSlider(
                                      items: demolist
                                          .map(
                                            (item) => Column(
                                              children: [
                                                SizedBox(
                                                  height: height / 15,
                                                ),
                                                Container(
                                                  width: width / 1.5,
                                                  height: height / 10,
                                                  padding: EdgeInsets.only(
                                                      left: width / 30,
                                                      right: width / 30),
                                                  child: Text(
                                                    '$item',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        letterSpacing: 0.5),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                          .toList(),
                                      options: CarouselOptions(
                                        height: height / 5,
                                        aspectRatio: 16 / 9,
                                        viewportFraction: 2,
                                        initialPage: 0,
                                        enableInfiniteScroll: true,
                                        reverse: false,
                                        autoPlay: true,
                                        onPageChanged: (index, reason) {
                                          setState(() {
                                            idex = index;
                                          });
                                        },
                                        autoPlayInterval: Duration(seconds: 3),
                                        autoPlayAnimationDuration:
                                            Duration(seconds: 1),
                                        autoPlayCurve: Curves.fastOutSlowIn,
                                        enlargeCenterPage: true,
                                        scrollDirection: Axis.horizontal,
                                      )),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: demolist.map((e) {
                                      int index = demolist.indexOf(e);
                                      return Container(
                                        margin: EdgeInsets.only(
                                            bottom: height / 20,
                                            left: width / 30),
                                        height: 4,
                                        width: width / 30,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: index == idex
                                                ? Colors.black
                                                : ColorsThemes.mailColors),
                                      );
                                    }).toList(),
                                  ),
                                )
                              ],
                            )),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  int idex = 0;

  dailogThisandFolwingEvent(
      {BlockFinalHomePage provider,
      int index,
      int oldindex,
      int newindex,
      bool isreorder}) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(20.0)), //this right here
                child: Container(
                    height: height / 3.7,
                    width: width,
                    padding: EdgeInsets.all(width / 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: height / 50,
                        ),
                        Text(
                          'Delete recurring event',
                          style: TextStyle(
                              color: ColorsThemes.lightBlackColor,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                              fontSize: 15),
                        ),
                        SizedBox(
                          height: height / 30,
                        ),
                        InkWell(
                          splashColor: Colors.white,
                          highlightColor: Colors.white,
                          onTap: () {
                            setState(() {
                              one = '1';
                            });
                            print('$one');
                          },
                          child: Row(
                            children: [
                              one == '1'
                                  ? Container(
                                      height: height / 40,
                                      width: width / 20,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: ColorsThemes.mailColors),
                                    )
                                  : Container(
                                      height: height / 40,
                                      width: width / 20,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: ColorsThemes.mailColors,
                                            width: 2),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                              SizedBox(
                                width: width / 20,
                              ),
                              Text(
                                'This event',
                                style: TextStyle(
                                    color: ColorsThemes.lightBlackColor,
                                    letterSpacing: 0.5,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height / 50,
                        ),
                        InkWell(
                          splashColor: Colors.white,
                          highlightColor: Colors.white,
                          onTap: () {
                            setState(() {
                              one = '2';
                            });
                            print('$one');
                          },
                          child: Row(
                            children: [
                              one == '2'
                                  ? Container(
                                      height: height / 40,
                                      width: width / 20,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: ColorsThemes.mailColors),
                                    )
                                  : Container(
                                      height: height / 40,
                                      width: width / 20,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: ColorsThemes.mailColors,
                                            width: 2),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                              SizedBox(
                                width: width / 20,
                              ),
                              Text(
                                'This and following events',
                                style: TextStyle(
                                    color: ColorsThemes.lightBlackColor,
                                    letterSpacing: 0.5,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height / 50,
                        ),
                        Center(
                          child: InkWell(
                            splashColor: Colors.white,
                            highlightColor: Colors.white,
                            onTap: () {
                              if (isreorder == true) {
                                provider.setreArangelist(
                                    newindex: newindex,
                                    oldindex: oldindex,
                                    event: one);
                                Navigator.of(context).pop();
                                ApiUtils.updatefinalTaskData(
                                    provider: provider);
                              } else {
                                Navigator.of(context).pop();
                                ApiUtils.deletefinalHomePagetask(
                                    context: context,
                                    provider: provider,
                                    id: provider.finalList[index]['id'],
                                    index: index,
                                    event: one);
                              }
                            },
                            child: Container(
                              height: height / 30,
                              width: width / 5,
                              decoration: BoxDecoration(
                                  color: ColorsThemes.mailColors,
                                  borderRadius: BorderRadius.circular(6)),
                              child: Center(
                                child: Text(
                                  'Submit',
                                  style: TextStyle(
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                      fontSize: 10),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
              );
            },
          );
        });
  }

  Future updateData() async {
    List data;
    int i = 0;
    data = await DBProvider.instance.getAllfinalHomePageDataRecord();
    DBProvider.instance.insertfinalHomePageData(FinalHomePageDataModel(
        id: data[i]['id'],
        name: data[i]['name'],
        start_time: '23:43:33',
        end_time: (data[i]['end_time']).toString(),
        point: (data[i]['point']).toString(),
        focus: (data[i]['focus']).toString(),
        bad_habbit: (data[i]['bad_habbit']).toString(),
        animation: (data[i]['animation']).toString(),
        audio: (data[i]['audio']).toString(),
        f_5_mins_before: (data[i]['_5_mins_before']).toString(),
        f_5_sec_before: (data[i]['_5_sec_before']).toString(),
        description: (data[i]['description']).toString(),
        color: (data[i]['color']).toString()));
  }
}

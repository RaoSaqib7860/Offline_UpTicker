import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:time_range_picker/time_range_picker.dart';
import 'package:upticker/ApiConfig/APiUtil.dart';
import 'package:upticker/ColorsThems/ThemesColors.dart';
import 'package:upticker/DBModels/FinalHomePageDataModel.dart';
import 'package:upticker/DataBase/DBClass.dart';
import 'package:upticker/Pages/FinalHomePage.dart';
import 'package:upticker/Provider/BlockFinalHomePage.dart';
import 'package:upticker/Provider/BlockSettings.dart';
import 'package:intl/intl.dart';
import 'package:upticker/Provider/BlockSinglePageEdition.dart';

import 'SingleTaskEdition.dart';

class Settings extends StatefulWidget {
  Settings(
      {Key key,
      this.id,
      this.token,
      this.index,
      this.aditSingle,
      this.taskName})
      : super(key: key);
  final String id;
  final String token;
  final int index;
  final bool aditSingle;
  final String taskName;

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isSwitched = false;
  bool lightTheme = true;
  Color currentColor = Colors.orange;
  DateFormat sdf2 = DateFormat("hh.mm aa");
  String one = '1';

  @override
  void initState() {
    final BlockSettings _provider =
        Provider.of<BlockSettings>(context, listen: false);
    _provider.setId('${widget.id}');
    _provider.settoken('${widget.token}');
    if (widget.aditSingle == true) {
      _provider.nameCon.text = '${widget.taskName}';
    }
    getAPiData(_provider);

    super.initState();
  }

  getAPiData(BlockSettings provider) async {
    await ApiUtils.getEditRecordSettingData(
        context: context, provider: provider);
    await ApiUtils.getSubTaskData(context: context, provider: provider);
    await ApiUtils.notegetSubTaskData(context: context, provider: provider);
  }

  Future<bool> onbackPress() async {
    final BlockSettings provider =
        Provider.of<BlockSettings>(context, listen: false);
    if (widget.aditSingle == true) {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (c) => ChangeNotifierProvider(
                  create: (_) => BlockSinglePageEdition(),
                  child: SingleTaskEdition())));
    } else {
      Navigator.push(
          context,
          PageTransition(
              duration: Duration(milliseconds: 200),
              type: PageTransitionType.leftToRight,
              child: ChangeNotifierProvider(
                create: (_) => BlockFinalHomePage(),
                child: FinalHomePageClass(),
              )));
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final BlockSettings _provider = Provider.of<BlockSettings>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () => onbackPress(),
      child: Scaffold(
          key: _provider.scaffoldKey,
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(height / 6.3),
            child: AppBar(
              flexibleSpace: Container(
                decoration: BoxDecoration(color: Colors.white),
                margin: EdgeInsets.only(top: height / 100),
                height: height / 6.3,
                child: Container(
                  height: height / 6.3,
                  width: width,
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: width / 10, right: width / 10),
                        height: double.infinity,
                        width: double.infinity,
                        child: Center(
                          child: widget.aditSingle == true
                              ? Container(
                                  width: width / 2,
                                  child: TextFormField(
                                    controller: _provider.nameCon,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.all(width / 40),
                                        labelStyle: TextStyle(
                                            fontSize: 10,
                                            letterSpacing: 0.5,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                )
                              : Text(
                                  'Task Settings',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300,
                                      letterSpacing: 0.3),
                                ),
                        ),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(color: Colors.black38, blurRadius: 2)
                            ],
                            color: ColorsThemes.darkThemeColor,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () {
                            if (widget.aditSingle == true) {
                              Navigator.of(context).pop();
                            } else {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      duration: Duration(milliseconds: 200),
                                      type: PageTransitionType.leftToRight,
                                      child: ChangeNotifierProvider(
                                        create: (_) => BlockFinalHomePage(),
                                        child: FinalHomePageClass(),
                                      )));
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: width / 30),
                            height: height / 14,
                            width: width / 7,
                            child: Center(
                              child: Icon(
                                Icons.clear,
                                size: 20,
                                color: ColorsThemes.darkThemeColor,
                              ),
                            ),
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Colors.blueGrey[300], blurRadius: 3)
                            ], shape: BoxShape.circle, color: Colors.white),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return StatefulBuilder(
                                    builder: (context, setState) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                20.0)), //this right here
                                        child: Container(
                                            height: height / 3.7,
                                            width: width,
                                            padding: EdgeInsets.all(width / 20),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: height / 50,
                                                ),
                                                Text(
                                                  'Edit recurring event',
                                                  style: TextStyle(
                                                      color: ColorsThemes
                                                          .lightBlackColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      letterSpacing: 0.5,
                                                      fontSize: 15),
                                                ),
                                                SizedBox(
                                                  height: height / 30,
                                                ),
                                                InkWell(
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
                                                              height:
                                                                  height / 40,
                                                              width: width / 20,
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: ColorsThemes
                                                                      .mailColors),
                                                            )
                                                          : Container(
                                                              height:
                                                                  height / 40,
                                                              width: width / 20,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: ColorsThemes
                                                                        .mailColors,
                                                                    width: 2),
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                            ),
                                                      SizedBox(
                                                        width: width / 20,
                                                      ),
                                                      Text(
                                                        'This event',
                                                        style: TextStyle(
                                                            color: ColorsThemes
                                                                .lightBlackColor,
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
                                                              height:
                                                                  height / 40,
                                                              width: width / 20,
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: ColorsThemes
                                                                      .mailColors),
                                                            )
                                                          : Container(
                                                              height:
                                                                  height / 40,
                                                              width: width / 20,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: ColorsThemes
                                                                        .mailColors,
                                                                    width: 2),
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                            ),
                                                      SizedBox(
                                                        width: width / 20,
                                                      ),
                                                      Text(
                                                        'This and following events',
                                                        style: TextStyle(
                                                            color: ColorsThemes
                                                                .lightBlackColor,
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
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      // updateData(_provider);
                                                      ApiUtils
                                                          .updateEditRecordSettingData(
                                                              context: context,
                                                              provider:
                                                                  _provider,
                                                              isEditSingle: widget
                                                                  .aditSingle,
                                                              event: one);
                                                      _provider
                                                          .setSerUploadedSubList();
                                                      ApiUtils.addSubTaskData(
                                                          context: context,
                                                          provider: _provider);
                                                      _provider
                                                          .notsetSerUploadedSubList();
                                                      ApiUtils
                                                          .notaddSubTaskData(
                                                              context: context,
                                                              provider:
                                                                  _provider);
                                                    },
                                                    child: Container(
                                                      height: height / 30,
                                                      width: width / 5,
                                                      decoration: BoxDecoration(
                                                          color: ColorsThemes
                                                              .mailColors,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6)),
                                                      child: Center(
                                                        child: Text(
                                                          'Submit',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              letterSpacing:
                                                                  0.5,
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
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: width / 30),
                            height: height / 14,
                            width: width / 7,
                            child: Center(
                              child: Icon(Icons.check,
                                  size: 20, color: Colors.red),
                            ),
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Colors.blueGrey[300], blurRadius: 3)
                            ], shape: BoxShape.circle, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              elevation: 0,
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
            ),
          ),
          body: AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            opacity: _provider.loading == false ? 0.3 : 1,
            child: AnimatedContainer(
              height: height,
              width: width,
              padding: EdgeInsets.only(
                  top: _provider.loading == false ? height / 10 : 0),
              curve: Curves.ease,
              duration: Duration(milliseconds: 500),
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
                  : CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Container(
                            height: height / 18,
                            margin: EdgeInsets.only(
                                left: width / 20, right: width / 20),
                            child: Row(
                              children: [
                                Text(
                                  'Point',
                                  style: TextStyle(
                                      color: ColorsThemes.lightBlackColor,
                                      fontSize: 15),
                                ),
                                InkWell(
                                  onTap: () {
                                    // showDialog(
                                    //   context: context,
                                    //   builder: (BuildContext context) {
                                    //     return AlertDialog(
                                    //       titlePadding:
                                    //           const EdgeInsets.all(0.0),
                                    //       contentPadding:
                                    //           const EdgeInsets.all(0.0),
                                    //       content: SingleChildScrollView(
                                    //         child: NumberPicker.integer(
                                    //             initialValue:
                                    //                 (_provider.point).toInt(),
                                    //             minValue: 0,
                                    //             maxValue: 500,
                                    //             onChanged: (val) {
                                    //               _provider.setpoint(
                                    //                   (val).toDouble());
                                    //             }),
                                    //       ),
                                    //     );
                                    // },
                                    //   );
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          titlePadding:
                                              const EdgeInsets.all(0.0),
                                          contentPadding:
                                              const EdgeInsets.all(0.0),
                                          content: SingleChildScrollView(
                                            child: Container(
                                              height: height / 2.5,
                                              width: width,
                                              padding: EdgeInsets.only(
                                                  left: width / 10,
                                                  right: width / 10),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: height / 20,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      _provider.setpoint(
                                                          (1).toDouble());
                                                    },
                                                    child: getRowData(context,
                                                        '1', 'Should do'),
                                                  ),
                                                  SizedBox(
                                                    height: height / 22,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      _provider.setpoint(
                                                          (2).toDouble());
                                                    },
                                                    child: getRowData(context,
                                                        '2', 'Important'),
                                                  ),
                                                  SizedBox(
                                                    height: height / 22,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      _provider.setpoint(
                                                          (3).toDouble());
                                                    },
                                                    child: getRowData(context,
                                                        '3', 'Very Important'),
                                                  ),
                                                  SizedBox(
                                                    height: height / 22,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      _provider.setpoint(
                                                          (4).toDouble());
                                                    },
                                                    child: getRowData(context,
                                                        '4', 'Crucial'),
                                                  ),
                                                  SizedBox(
                                                    height: height / 22,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      _provider.setpoint(
                                                          (5).toDouble());
                                                    },
                                                    child: getRowData(context,
                                                        '5', 'Height Priority'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    height: height / 24,
                                    width: width / 12,
                                    child: Center(
                                        child: Text(
                                      '${(_provider.point).toInt()}',
                                      style: TextStyle(fontSize: 10),
                                    )),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: ColorsThemes.mailColors,
                                            width: 1)),
                                  ),
                                )
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Container(
                            height: height / 18,
                            padding: EdgeInsets.only(
                                left: width / 20, right: width / 20),
                            color: ColorsThemes.offGraycolor,
                            child: Row(
                              children: [
                                Text(
                                  'Frequency',
                                  style: TextStyle(
                                      color: ColorsThemes.lightBlackColor,
                                      fontSize: 15),
                                ),
                                Text(
                                  'Daily',
                                  style: TextStyle(
                                      color: ColorsThemes.mailColors,
                                      fontSize: 15),
                                ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Container(
                            height: height / 18,
                            margin: EdgeInsets.only(
                                left: width / 20, right: width / 20),
                            child: Row(
                              children: [
                                Text(
                                  'Time Per Day',
                                  style: TextStyle(
                                      color: ColorsThemes.lightBlackColor,
                                      fontSize: 15),
                                ),
                                Container(
                                  height: height / 24,
                                  width: width / 12,
                                  child: Center(child: Text('1')),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: ColorsThemes.mailColors,
                                          width: 1)),
                                )
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            return AnimatedContainer(
                              width: width,
                              margin: EdgeInsets.only(top: width / 50),
                              height: height / 20,
                              duration: Duration(milliseconds: 500),
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: width / 15, right: width / 15),
                                child: TextFormField(
                                  controller: _provider.conlist[index],
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      suffixIcon: IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.black45,
                                            size: 20,
                                          ),
                                          onPressed: () {
                                            TextEditingController con =
                                                _provider.conlist[index];
                                            if (con.text.isEmpty) {
                                              _provider
                                                  .deleteselectedSubTask(index);
                                            } else {
                                              ApiUtils.deleteSubTaskData(
                                                  context: context,
                                                  provider: _provider,
                                                  id: _provider
                                                          .serversubList[index]
                                                      ['id'],
                                                  index: index);
                                            }
                                          }),
                                      hintText: 'Enter Title',
                                      hintStyle: TextStyle(fontSize: 13),
                                      contentPadding: EdgeInsets.only(
                                          left: width / 30,
                                          bottom: width / 40)),
                                ),
                                height: height / 20,
                                decoration:
                                    BoxDecoration(color: Colors.blueGrey[100]),
                                width: width,
                              ),
                            );
                          }, childCount: _provider.conlist.length),
                        ),
                        SliverToBoxAdapter(
                          child: Container(
                            height: height / 18,
                            margin: EdgeInsets.only(
                                left: width / 20, right: width / 20),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    TextEditingController controller =
                                        TextEditingController();
                                    _provider.setConList(controller);
                                    _provider.setConUploadedList(controller);
                                  },
                                  child: Text(
                                    'Add Subtask',
                                    style: TextStyle(
                                        color: ColorsThemes.mailColors,
                                        fontSize: 15),
                                  ),
                                ),
                                _provider.conlist.length == 0
                                    ? Container()
                                    : InkWell(
                                        onTap: () {
                                          _provider.deleteAllSubTask();
                                        },
                                        child: Text(
                                          'Delete All',
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 15),
                                        ),
                                      ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: InkWell(
                            onTap: () async {
                              print('${_provider.startTime}');
                              var ddd = (DateTime.now()).toString();
                              List l = ddd.split(' ');
                              print('${l[0]}');
                              DatePicker.showTime12hPicker(context,
                                  showTitleActions: true, onChanged: (date) {
                                print('change $date in time zone ' +
                                    date.timeZoneOffset.inHours.toString());
                              }, onConfirm: (date) {
                                _provider.setStartTime(
                                    '${date.hour}:${date.minute}:30');
                              },
                                  currentTime: DateTime.parse(
                                      '${l[0]} ${_provider.startTime}'));
                            },
                            child: Container(
                              height: height / 18,
                              padding: EdgeInsets.only(
                                  left: width / 20, right: width / 20),
                              color: ColorsThemes.offGraycolor,
                              child: Row(
                                children: [
                                  Text(
                                    'Start Time',
                                    style: TextStyle(
                                        color: ColorsThemes.lightBlackColor,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    '${sdf2.format(DateFormat('Hms').parse(_provider.startTime))}',
                                    style: TextStyle(
                                        color: ColorsThemes.mailColors,
                                        fontSize: 15),
                                  ),
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              ),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: InkWell(
                            onTap: () async {
                              List l =
                                  _provider.startTime.toString().split(':');
                              List l2 = _provider.endTime.toString().split(':');
                              print('$l');
                              TimeRange result = await showTimeRangePicker(
                                  context: context,
                                  start: TimeOfDay(
                                    hour: int.parse(l[0]),
                                    minute: int.parse(l[1]),
                                  ),
                                  end: TimeOfDay(
                                    hour: int.parse(l2[0]),
                                    minute: int.parse(l2[1]),
                                  ),
                                  disabledColor: Colors.red.withOpacity(0.5),
                                  strokeWidth: 2,
                                  use24HourFormat: true,
                                  ticks: 24,
                                  ticksOffset: -7,
                                  ticksLength: 15,
                                  ticksColor: Colors.grey,
                                  labels: [
                                    "12 pm",
                                    "3 am",
                                    "6 am",
                                    "9 am",
                                    "12 am",
                                    "3 pm",
                                    "6 pm",
                                    "9 pm"
                                  ].asMap().entries.map((e) {
                                    return ClockLabel.fromIndex(
                                        idx: e.key, length: 8, text: e.value);
                                  }).toList(),
                                  labelOffset: 35,
                                  rotateLabels: false,
                                  padding: 60);
                              _provider.setendTime(
                                  '${result.endTime.hour}:${result.endTime.minute}:30');
                              _provider.setStartTime(
                                  '${result.startTime.hour}:${result.startTime.minute}:30');
                            },
                            child: Container(
                              height: height / 18,
                              margin: EdgeInsets.only(
                                  left: width / 20, right: width / 20),
                              child: Row(
                                children: [
                                  Text(
                                    'End Time',
                                    style: TextStyle(
                                        color: ColorsThemes.lightBlackColor,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    '${sdf2.format(DateFormat('Hms').parse(_provider.endTime))}',
                                    style: TextStyle(
                                        color: ColorsThemes.mailColors,
                                        fontSize: 15),
                                  ),
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              ),
                            ),
                          ),
                        ),
                        // SliverToBoxAdapter(
                        //   child: Container(
                        //     height: height / 18,
                        //     padding: EdgeInsets.only(
                        //         left: width / 20, right: width / 20),
                        //     color: ColorsThemes.offGraycolor,
                        //     child: Row(
                        //       children: [
                        //         InkWell(
                        //           onTap: () {
                        //             _provider.displayBottomSheet(context);
                        //           },
                        //           child: Text(
                        //             'Link App',
                        //             style: TextStyle(
                        //                 color: ColorsThemes.lightBlackColor,
                        //                 fontSize: 15),
                        //           ),
                        //         ),
                        //         Switch(
                        //           value: isSwitched,
                        //           onChanged: (value) {
                        //             setState(() {
                        //               isSwitched = value;
                        //               print(isSwitched);
                        //             });
                        //           },
                        //           activeTrackColor: ColorsThemes.ringThemeColor,
                        //           activeColor: ColorsThemes.mailColors,
                        //         ),
                        //       ],
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     ),
                        //   ),
                        // ),
                        // SliverToBoxAdapter(
                        //   child: Container(
                        //     height: height / 18,
                        //     margin: EdgeInsets.only(
                        //         left: width / 20, right: width / 20),
                        //     child: Row(
                        //       children: [
                        //         Text(
                        //           'Pin Task',
                        //           style: TextStyle(
                        //               color: ColorsThemes.lightBlackColor,
                        //               fontSize: 15),
                        //         ),
                        //         Switch(
                        //           value: isSwitched,
                        //           onChanged: (value) {
                        //             setState(() {
                        //               isSwitched = value;
                        //               print(isSwitched);
                        //             });
                        //           },
                        //           activeTrackColor: ColorsThemes.ringThemeColor,
                        //           activeColor: ColorsThemes.mailColors,
                        //         ),
                        //       ],
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     ),
                        //   ),
                        // ),
                        SliverToBoxAdapter(
                          child: Container(
                            height: height / 18,
                            padding: EdgeInsets.only(
                                left: width / 20, right: width / 20),
                            color: ColorsThemes.offGraycolor,
                            child: Row(
                              children: [
                                Text(
                                  '5 mins before',
                                  style: TextStyle(
                                      color: ColorsThemes.lightBlackColor,
                                      fontSize: 15),
                                ),
                                Switch(
                                  value: _provider.fiveminBefore == true
                                      ? true
                                      : false,
                                  onChanged: (value) {
                                    if (_provider.fiveminBefore == true) {
                                      _provider.set5minBefore(false);
                                    } else {
                                      _provider.set5minBefore(true);
                                    }
                                  },
                                  activeTrackColor: ColorsThemes.ringThemeColor,
                                  activeColor: ColorsThemes.mailColors,
                                ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Container(
                            height: height / 18,
                            margin: EdgeInsets.only(
                                left: width / 20, right: width / 20),
                            child: Row(
                              children: [
                                Text(
                                  '5 seconds before',
                                  style: TextStyle(
                                      color: ColorsThemes.lightBlackColor,
                                      fontSize: 15),
                                ),
                                Switch(
                                  value: _provider.fiveSecBefore == true
                                      ? true
                                      : false,
                                  onChanged: (value) {
                                    if (_provider.fiveSecBefore == true) {
                                      _provider.set5SecBefore(false);
                                    } else {
                                      _provider.set5SecBefore(true);
                                    }
                                  },
                                  activeTrackColor: ColorsThemes.ringThemeColor,
                                  activeColor: ColorsThemes.mailColors,
                                ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Container(
                            height: height / 18,
                            padding: EdgeInsets.only(
                                left: width / 20, right: width / 20),
                            color: ColorsThemes.offGraycolor,
                            child: Row(
                              children: [
                                Text(
                                  'Focus',
                                  style: TextStyle(
                                      color: ColorsThemes.lightBlackColor,
                                      fontSize: 15),
                                ),
                                Switch(
                                  value: _provider.focus == true ? true : false,
                                  onChanged: (value) {
                                    if (_provider.focus == true) {
                                      _provider.setfocus(false);
                                    } else {
                                      _provider.setfocus(true);
                                    }
                                  },
                                  activeTrackColor: ColorsThemes.ringThemeColor,
                                  activeColor: ColorsThemes.mailColors,
                                ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Container(
                            height: height / 18,
                            margin: EdgeInsets.only(
                                left: width / 20, right: width / 20),
                            child: Row(
                              children: [
                                Text(
                                  'Pin Task',
                                  style: TextStyle(
                                      color: ColorsThemes.lightBlackColor,
                                      fontSize: 15),
                                ),
                                Switch(
                                  value: _provider.pintask ? true : false,
                                  onChanged: (value) {
                                    if (_provider.pintask == true) {
                                      _provider.setpintask(false);
                                    } else {
                                      _provider.setpintask(true);
                                    }
                                  },
                                  activeTrackColor: ColorsThemes.ringThemeColor,
                                  activeColor: ColorsThemes.mailColors,
                                ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Container(
                            height: height / 18,
                            margin: EdgeInsets.only(
                                left: width / 20, right: width / 20),
                            child: Row(
                              children: [
                                Text(
                                  'Bad Habit',
                                  style: TextStyle(
                                      color: ColorsThemes.lightBlackColor,
                                      fontSize: 15),
                                ),
                                Switch(
                                  value:
                                      _provider.badHabit == true ? true : false,
                                  onChanged: (value) {
                                    if (_provider.badHabit == true) {
                                      _provider.setBadHabit(false);
                                    } else {
                                      _provider.setBadHabit(true);
                                    }
                                  },
                                  activeTrackColor: ColorsThemes.ringThemeColor,
                                  activeColor: ColorsThemes.mailColors,
                                ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Container(
                            height: height / 18,
                            padding: EdgeInsets.only(
                                left: width / 20, right: width / 10),
                            color: ColorsThemes.offGraycolor,
                            child: Row(
                              children: [
                                Text(
                                  'Color',
                                  style: TextStyle(
                                      color: ColorsThemes.lightBlackColor,
                                      fontSize: 15),
                                ),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                          builder: (context, setState) {
                                            return Container(
                                              child: Material(
                                                color: Colors.transparent,
                                                child: ElasticInUp(
                                                  duration:
                                                      Duration(seconds: 1),
                                                  child: Container(
                                                    padding: EdgeInsets.all(
                                                        width / 20),
                                                    height: height,
                                                    width: width,
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Icon(
                                                                Icons
                                                                    .arrow_back_ios,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: width / 30,
                                                            ),
                                                            Text(
                                                              'Colors',
                                                              style: TextStyle(
                                                                  letterSpacing:
                                                                      2,
                                                                  fontSize: 20),
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: height / 30,
                                                        ),
                                                        Expanded(
                                                            child: ListView
                                                                .builder(
                                                          itemBuilder: (c, i) {
                                                            return Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      top: height /
                                                                          40),
                                                              child: InkWell(
                                                                onTap: () {
                                                                  for (var i =
                                                                          0;
                                                                      i <
                                                                          _provider
                                                                              .listofColors
                                                                              .length;
                                                                      i++) {
                                                                    _provider
                                                                        .setlistofColorsbool(
                                                                            i,
                                                                            false);
                                                                  }
                                                                  _provider
                                                                      .setlistofColorsbool(
                                                                          i,
                                                                          true);
                                                                  _provider.setPColors(
                                                                      _provider
                                                                          .listofColors[i]);
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  _provider.setColor(
                                                                      _provider
                                                                          .listOfColorValue[i]);
                                                                },
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          height /
                                                                              30,
                                                                      width:
                                                                          width /
                                                                              15,
                                                                      decoration: BoxDecoration(
                                                                          color: _provider.listofColors[
                                                                              i],
                                                                          borderRadius:
                                                                              BorderRadius.circular(5)),
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          width /
                                                                              30,
                                                                    ),
                                                                    Text(
                                                                      '${_provider.listofColorstext[i]}',
                                                                      style: TextStyle(
                                                                          letterSpacing:
                                                                              1,
                                                                          fontSize:
                                                                              12),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerRight,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.only(right: width / 20),
                                                                          child:
                                                                              Icon(
                                                                            Icons.check,
                                                                            color: _provider.listofColorsbool[i] == false
                                                                                ? Colors.white
                                                                                : Colors.blue,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          itemCount: _provider
                                                              .listofColors
                                                              .length,
                                                        )),
                                                        SizedBox(
                                                          height: height / 30,
                                                        ),
                                                      ],
                                                    ),
                                                    margin: EdgeInsets.only(
                                                        top: height / 10),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        15),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        15)),
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    height: height / 24,
                                    width: width / 12,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _provider.colorChange == false
                                            ? Color.fromARGB(
                                                255,
                                                int.parse(_provider.color[0]),
                                                int.parse(_provider.color[1]),
                                                int.parse(_provider.color[2]))
                                            : _provider.pcolor),
                                  ),
                                )
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            return AnimatedContainer(
                              width: width,
                              margin: EdgeInsets.only(top: width / 50),
                              height: height / 20,
                              duration: Duration(milliseconds: 500),
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: width / 15, right: width / 15),
                                child: TextFormField(
                                  controller: _provider.notconlist[index],
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      suffixIcon: IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.black45,
                                            size: 20,
                                          ),
                                          onPressed: () {
                                            TextEditingController con =
                                                _provider.notconlist[index];
                                            if (con.text.isEmpty) {
                                              _provider
                                                  .notdeleteselectedSubTask(
                                                      index);
                                            } else {
                                              ApiUtils.notdeleteSubTaskData(
                                                  context: context,
                                                  provider: _provider,
                                                  id: _provider
                                                          .notserversubList[
                                                      index]['id'],
                                                  index: index);
                                            }
                                          }),
                                      hintText: 'Enter Title',
                                      hintStyle: TextStyle(fontSize: 13),
                                      contentPadding: EdgeInsets.only(
                                          left: width / 30,
                                          bottom: width / 40)),
                                ),
                                height: height / 20,
                                decoration:
                                    BoxDecoration(color: Colors.blueGrey[100]),
                                width: width,
                              ),
                            );
                          }, childCount: _provider.notconlist.length),
                        ),
                        SliverToBoxAdapter(
                          child: Container(
                            height: height / 18,
                            margin: EdgeInsets.only(
                                left: width / 20, right: width / 20),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    TextEditingController controller =
                                        TextEditingController();
                                    _provider.notsetConList(controller);
                                    _provider.notsetConUploadedList(controller);
                                  },
                                  child: Text(
                                    'Add Note',
                                    style: TextStyle(
                                        color: ColorsThemes.mailColors,
                                        fontSize: 15),
                                  ),
                                ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          )),
    );
  }

  Widget getRowData(BuildContext context, String point, String text) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$point     $text',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        Container(
            height: height / 40,
            width: width / 20,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: ColorsThemes.mailColors, width: 2)))
      ],
    );
  }

  Future updateData(BlockSettings provider) async {
    DBProvider.instance.insertfinalHomePageData(FinalHomePageDataModel(
        id: int.parse(widget.id),
        name: '${provider.name}',
        start_time: '${provider.startTime}',
        end_time: '${provider.endTime}',
        point: '${provider.point}',
        focus: '${provider.focus}',
        bad_habbit: '${provider.badHabit}',
        animation: '${provider.animation}',
        audio: '${provider.audio}',
        f_5_mins_before: '${provider.fiveminBefore}',
        f_5_sec_before: '${provider.fiveSecBefore}',
        description: '${provider.setDiscription}',
        color: '${provider.color}'));
  }
}

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:time_range_picker/time_range_picker.dart';
import 'package:upticker/ApiConfig/APiUtil.dart';
import 'package:upticker/ColorsThems/ThemesColors.dart';
import 'package:upticker/LocalWidget/LocalWidget.dart';
import 'package:upticker/Provider/BlockAddCustomTask.dart';
import 'package:provider/provider.dart';
import 'package:upticker/ServicesForApp/FireBaseAnalytics.dart';

class AddCustomTask extends StatefulWidget {
  AddCustomTask({Key key}) : super(key: key);

  @override
  _AddCustomTaskState createState() => _AddCustomTaskState();
}

class _AddCustomTaskState extends State<AddCustomTask> {
  bool isSwitched = false;
  bool lightTheme = true;
  Color currentColor = Colors.orange;
  DateFormat sdf2 = DateFormat("hh.mm aa");
  String one = '1';

  @override
  void initState() {
    final BlockAddCustomTask _provider =
        Provider.of<BlockAddCustomTask>(context, listen: false);
    _provider.setintialData();
    apicaling(_provider);
    FireBaseAnalyticsServices.setCurrentScreen(
        screenClass: 'Add Custom Task', screenName: 'Add Custom Task class');
    super.initState();
  }

  apicaling(BlockAddCustomTask provider) {
    ApiUtils.getCustomBucketTaskDataINADDTASK(provider: provider);
  }

  getSubBucket({BlockAddCustomTask provider, id}) async {
    await ApiUtils.getSubCustomBucketTaskDataINADDTASK(
        id: id, provider: provider);
  }

  Future onbackpress() async {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final BlockAddCustomTask _provider =
        Provider.of<BlockAddCustomTask>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
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
                      margin:
                          EdgeInsets.only(left: width / 10, right: width / 10),
                      height: double.infinity,
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          'Add task',
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
                        splashColor: Colors.white,
                        highlightColor: Colors.white,
                        onTap: () {
                          onbackpress();
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
                        splashColor: Colors.white,
                        highlightColor: Colors.white,
                        onTap: () {
                          if (_provider.tasname.text.isNotEmpty) {
                            if (_provider.discription.text.isNotEmpty) {
                              if (_provider.selectedSubid != null) {
                                ApiUtils.addcustomTaskData(
                                    provider: _provider, event: one);
                                // showDialog(
                                //     context: context,
                                //     builder: (context) {
                                //       return StatefulBuilder(
                                //         builder: (context, setState) {
                                //           return Dialog(
                                //             shape: RoundedRectangleBorder(
                                //                 borderRadius:
                                //                     BorderRadius.circular(
                                //                         20.0)), //this right here
                                //             child: FadeIn(
                                //               child: Container(
                                //                   height: height / 3.8,
                                //                   width: width,
                                //                   padding: EdgeInsets.all(
                                //                       width / 20),
                                //                   child: Column(
                                //                     mainAxisAlignment:
                                //                         MainAxisAlignment.start,
                                //                     crossAxisAlignment:
                                //                         CrossAxisAlignment
                                //                             .start,
                                //                     children: [
                                //                       SizedBox(
                                //                         height: height / 50,
                                //                       ),
                                //                       Text(
                                //                         'Edit recurring event',
                                //                         style: TextStyle(
                                //                             color: ColorsThemes
                                //                                 .lightBlackColor,
                                //                             fontWeight:
                                //                                 FontWeight.bold,
                                //                             letterSpacing: 0.5,
                                //                             fontSize: 15),
                                //                       ),
                                //                       SizedBox(
                                //                         height: height / 30,
                                //                       ),
                                //                       InkWell(
                                //                         splashColor:
                                //                             Colors.white,
                                //                         highlightColor:
                                //                             Colors.white,
                                //                         onTap: () {
                                //                           setState(() {
                                //                             one = '1';
                                //                           });
                                //                           print('$one');
                                //                         },
                                //                         child: Row(
                                //                           children: [
                                //                             one == '1'
                                //                                 ? Container(
                                //                                     height:
                                //                                         height /
                                //                                             40,
                                //                                     width:
                                //                                         width /
                                //                                             20,
                                //                                     decoration: BoxDecoration(
                                //                                         shape: BoxShape
                                //                                             .circle,
                                //                                         color: ColorsThemes
                                //                                             .mailColors),
                                //                                   )
                                //                                 : Container(
                                //                                     height:
                                //                                         height /
                                //                                             40,
                                //                                     width:
                                //                                         width /
                                //                                             20,
                                //                                     decoration:
                                //                                         BoxDecoration(
                                //                                       border: Border.all(
                                //                                           color: ColorsThemes
                                //                                               .mailColors,
                                //                                           width:
                                //                                               2),
                                //                                       shape: BoxShape
                                //                                           .circle,
                                //                                     ),
                                //                                   ),
                                //                             SizedBox(
                                //                               width: width / 20,
                                //                             ),
                                //                             Text(
                                //                               'This event',
                                //                               style: TextStyle(
                                //                                   color: ColorsThemes
                                //                                       .lightBlackColor,
                                //                                   letterSpacing:
                                //                                       0.5,
                                //                                   fontSize: 12),
                                //                             ),
                                //                           ],
                                //                         ),
                                //                       ),
                                //                       SizedBox(
                                //                         height: height / 50,
                                //                       ),
                                //                       InkWell(
                                //                         splashColor:
                                //                             Colors.white,
                                //                         highlightColor:
                                //                             Colors.white,
                                //                         onTap: () {
                                //                           setState(() {
                                //                             one = '2';
                                //                           });
                                //                           print('$one');
                                //                         },
                                //                         child: Row(
                                //                           children: [
                                //                             one == '2'
                                //                                 ? Container(
                                //                                     height:
                                //                                         height /
                                //                                             40,
                                //                                     width:
                                //                                         width /
                                //                                             20,
                                //                                     decoration: BoxDecoration(
                                //                                         shape: BoxShape
                                //                                             .circle,
                                //                                         color: ColorsThemes
                                //                                             .mailColors),
                                //                                   )
                                //                                 : Container(
                                //                                     height:
                                //                                         height /
                                //                                             40,
                                //                                     width:
                                //                                         width /
                                //                                             20,
                                //                                     decoration:
                                //                                         BoxDecoration(
                                //                                       border: Border.all(
                                //                                           color: ColorsThemes
                                //                                               .mailColors,
                                //                                           width:
                                //                                               2),
                                //                                       shape: BoxShape
                                //                                           .circle,
                                //                                     ),
                                //                                   ),
                                //                             SizedBox(
                                //                               width: width / 20,
                                //                             ),
                                //                             Text(
                                //                               'This and following events',
                                //                               style: TextStyle(
                                //                                   color: ColorsThemes
                                //                                       .lightBlackColor,
                                //                                   letterSpacing:
                                //                                       0.5,
                                //                                   fontSize: 12),
                                //                             ),
                                //                           ],
                                //                         ),
                                //                       ),
                                //                       SizedBox(
                                //                         height: height / 50,
                                //                       ),
                                //                       Center(
                                //                         child: InkWell(
                                //                           splashColor:
                                //                               Colors.white,
                                //                           highlightColor:
                                //                               Colors.white,
                                //                           onTap: () {
                                //                             Navigator.of(
                                //                                     context)
                                //                                 .pop();
                                //                             if (_provider
                                //                                 .tasname
                                //                                 .text
                                //                                 .isNotEmpty) {
                                //                               print(
                                //                                   'color string ${_provider.colorString}');
                                //                               print(
                                //                                 'sub_bucket: ${_provider.selectedSubid}',
                                //                               );
                                //                               print(
                                //                                   'end time ${_provider.endTime}');
                                //                               print(
                                //                                 'start time: ${_provider.startTime}',
                                //                               );
                                //                               ApiUtils.addcustomTaskData(
                                //                                   provider:
                                //                                       _provider,
                                //                                   event: one);
                                //                             }
                                //                           },
                                //                           child: Container(
                                //                             height: height / 30,
                                //                             width: width / 5,
                                //                             decoration: BoxDecoration(
                                //                                 color: ColorsThemes
                                //                                     .mailColors,
                                //                                 borderRadius:
                                //                                     BorderRadius
                                //                                         .circular(
                                //                                             6)),
                                //                             child: Center(
                                //                               child: Text(
                                //                                 'Submit',
                                //                                 style: TextStyle(
                                //                                     color: Colors
                                //                                         .white,
                                //                                     letterSpacing:
                                //                                         0.5,
                                //                                     fontSize:
                                //                                         10),
                                //                               ),
                                //                             ),
                                //                           ),
                                //                         ),
                                //                       )
                                //                     ],
                                //                   )),
                                //             ),
                                //           );
                                //         },
                                //       );
                                //     });
                              } else {
                                LocalWidgets.snackbar(_provider.scaffoldKey,
                                    'Please select bucket', Colors.black);
                              }
                            } else {
                              LocalWidgets.snackbar(_provider.scaffoldKey,
                                  'Please enter discription', Colors.black);
                            }
                          } else {
                            LocalWidgets.snackbar(_provider.scaffoldKey,
                                'Please enter name', Colors.black);
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: width / 30),
                          height: height / 14,
                          width: width / 7,
                          child: Center(
                            child:
                                Icon(Icons.check, size: 20, color: Colors.red),
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
        body: Container(
          height: height,
          width: width,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(
                      left: width / 20, right: width / 20, bottom: height / 50),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          spreadRadius: 2.0,
                          offset: Offset(
                            3.0,
                            5.0,
                          ),
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    controller: _provider.tasname,
                    style: TextStyle(color: Colors.black, fontSize: 14),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(width / 40),
                        labelText: 'Task Name',
                        labelStyle: TextStyle(
                            fontSize: 11,
                            fontFamily: 'Comfortaa',
                            letterSpacing: 0.3,
                            color: Colors.black38,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: AnimatedContainer(
                  margin: EdgeInsets.only(
                      left: width / 20, right: width / 20, bottom: height / 50),
                  duration: Duration(milliseconds: 800),
                  curve: Curves.ease,
                  width: width,
                  height: height / 6,
                  child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            spreadRadius: 2.0,
                            offset: Offset(
                              3.0,
                              5.0,
                            ),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: TextFormField(
                      controller: _provider.discription,
                      maxLines: 5,
                      textInputAction: TextInputAction.done,
                      style: TextStyle(color: Colors.black, fontSize: 14),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(width / 40),
                          hintText: 'Description',
                          hintStyle: TextStyle(
                              fontSize: 11,
                              fontFamily: 'Comfortaa',
                              letterSpacing: 0.3,
                              color: Colors.black38,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: InkWell(
                  onTap: () {
                    if (_provider.isShowBuckets == true) {
                      _provider.setisShowBucket(false);
                    } else {
                      _provider.setisShowBucket(true);
                    }
                  },
                  child: Container(
                    padding:
                        EdgeInsets.only(left: width / 20, right: width / 20),
                    height: height / 15,
                    width: width,
                    decoration: BoxDecoration(color: ColorsThemes.offGraycolor),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  'Bucket',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 14,
                                      letterSpacing: 0.5,
                                      color: ColorsThemes.lightBlackColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                            _provider.isShowBuckets == true
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: ColorsThemes.ringThemeColor),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    ),
                  ),
                ),
              ),
              _provider.isShowBuckets == false
                  ? SliverToBoxAdapter()
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              _provider.setisShowBucket(false);
                              _provider.setisShowSubBuckets(true);
                              getSubBucket(
                                  provider: _provider,
                                  id: '${_provider.listofBucket[index]['id']}');
                            },
                            splashColor: Colors.white,
                            highlightColor: Colors.white,
                            child: FadeInDown(
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: width / 20, right: width / 20),
                                height: height / 22,
                                width: width,
                                decoration: BoxDecoration(color: Colors.white),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: height / 14,
                                            width: width / 7,
                                            padding: EdgeInsets.all(width / 40),
                                            child: Image.network(
                                                '${ApiUtils.apiURL}${_provider.listofBucket[index]['icon']}'),
                                          ),
                                          SizedBox(
                                            width: width / 40,
                                          ),
                                          Expanded(
                                            child: Text(
                                              '${_provider.listofBucket[index]['name']}',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  letterSpacing: 0.5,
                                                  color: ColorsThemes
                                                      .lightBlackColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                ),
                              ),
                            ),
                          );
                        },
                        childCount: _provider.listofBucket.length,
                      ),
                    ),
              SliverToBoxAdapter(
                child: InkWell(
                  onTap: () {
                    if (_provider.isShowSubBuckets == true) {
                      _provider.setisShowSubBuckets(false);
                    } else {
                      _provider.setisShowSubBuckets(true);
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: height / 70),
                    padding:
                        EdgeInsets.only(left: width / 20, right: width / 20),
                    height: height / 15,
                    width: width,
                    decoration: BoxDecoration(color: ColorsThemes.offGraycolor),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  'Sub Bucket',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 14,
                                      letterSpacing: 0.5,
                                      color: ColorsThemes.lightBlackColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                            _provider.isShowSubBuckets == true
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: ColorsThemes.ringThemeColor),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    ),
                  ),
                ),
              ),
              _provider.listofSubBucket.length < 1
                  ? SliverToBoxAdapter()
                  : _provider.isShowSubBuckets == false
                      ? SliverToBoxAdapter()
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  _provider.setselectedSubid(
                                      _provider.listofSubBucket[index]['id']);
                                },
                                splashColor: Colors.white,
                                highlightColor: Colors.white,
                                child: FadeInDown(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: width / 20, right: width / 20),
                                    height: height / 22,
                                    width: width,
                                    decoration:
                                        BoxDecoration(color: Colors.white),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: height / 14,
                                                width: width / 7,
                                                padding:
                                                    EdgeInsets.all(width / 40),
                                                child: Image.network(
                                                    '${ApiUtils.apiURL}${_provider.listofSubBucket[index]['icon']}',
                                                    color: _provider.listofSubBucket[
                                                                index]['id'] ==
                                                            _provider
                                                                .selectedSubid
                                                        ? Colors.blue
                                                        : ColorsThemes
                                                            .lightBlackColor),
                                              ),
                                              SizedBox(
                                                width: width / 40,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  '${_provider.listofSubBucket[index]['name']}',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      letterSpacing: 0.5,
                                                      color: _provider.listofSubBucket[
                                                                      index]
                                                                  ['id'] ==
                                                              _provider
                                                                  .selectedSubid
                                                          ? Colors.blue
                                                          : ColorsThemes
                                                              .lightBlackColor),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                    ),
                                  ),
                                ),
                              );
                            },
                            childCount: _provider.listofSubBucket.length,
                          ),
                        ),
              SliverToBoxAdapter(
                child: Container(
                  height: height / 18,
                  margin: EdgeInsets.only(left: width / 20, right: width / 20),
                  child: Row(
                    children: [
                      Text(
                        'Point',
                        style: TextStyle(
                            color: ColorsThemes.lightBlackColor, fontSize: 15),
                      ),
                      InkWell(
                        splashColor: Colors.white,
                        highlightColor: Colors.white,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ZoomIn(
                                child: AlertDialog(
                                  titlePadding: const EdgeInsets.all(0.0),
                                  contentPadding: const EdgeInsets.all(0.0),
                                  content: SingleChildScrollView(
                                    child: ZoomIn(
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
                                              splashColor: Colors.white,
                                              highlightColor: Colors.white,
                                              onTap: () {
                                                Navigator.of(context).pop();
                                                _provider
                                                    .setpoint((1).toDouble());
                                              },
                                              child: getRowData(
                                                  context, '1', 'Should do'),
                                            ),
                                            SizedBox(
                                              height: height / 22,
                                            ),
                                            InkWell(
                                              splashColor: Colors.white,
                                              highlightColor: Colors.white,
                                              onTap: () {
                                                Navigator.of(context).pop();
                                                _provider
                                                    .setpoint((2).toDouble());
                                              },
                                              child: getRowData(
                                                  context, '2', 'Important'),
                                            ),
                                            SizedBox(
                                              height: height / 22,
                                            ),
                                            InkWell(
                                              splashColor: Colors.white,
                                              highlightColor: Colors.white,
                                              onTap: () {
                                                Navigator.of(context).pop();
                                                _provider
                                                    .setpoint((3).toDouble());
                                              },
                                              child: getRowData(context, '3',
                                                  'Very Important'),
                                            ),
                                            SizedBox(
                                              height: height / 22,
                                            ),
                                            InkWell(
                                              splashColor: Colors.white,
                                              highlightColor: Colors.white,
                                              onTap: () {
                                                Navigator.of(context).pop();
                                                _provider
                                                    .setpoint((4).toDouble());
                                              },
                                              child: getRowData(
                                                  context, '4', 'Crucial'),
                                            ),
                                            SizedBox(
                                              height: height / 22,
                                            ),
                                            InkWell(
                                              splashColor: Colors.white,
                                              highlightColor: Colors.white,
                                              onTap: () {
                                                Navigator.of(context).pop();
                                                _provider
                                                    .setpoint((5).toDouble());
                                              },
                                              child: getRowData(context, '5',
                                                  'Height Priority'),
                                            ),
                                          ],
                                        ),
                                      ),
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
                                  color: ColorsThemes.mailColors, width: 1)),
                        ),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ),
              ),
              // SliverToBoxAdapter(
              //   child: Container(
              //     height: height / 18,
              //     padding: EdgeInsets.only(left: width / 20, right: width / 20),
              //     color: ColorsThemes.offGraycolor,
              //     child: Row(
              //       children: [
              //         Text(
              //           'Frequency',
              //           style: TextStyle(
              //               color: ColorsThemes.lightBlackColor, fontSize: 15),
              //         ),
              //         Text(
              //           'Daily',
              //           style: TextStyle(
              //               color: ColorsThemes.mailColors, fontSize: 15),
              //         ),
              //       ],
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     ),
              //   ),
              // ),
              // SliverToBoxAdapter(
              //   child: Container(
              //     height: height / 18,
              //     margin: EdgeInsets.only(left: width / 20, right: width / 20),
              //     child: Row(
              //       children: [
              //         Text(
              //           'Time Per Day',
              //           style: TextStyle(
              //               color: ColorsThemes.lightBlackColor, fontSize: 15),
              //         ),
              //         Container(
              //           height: height / 24,
              //           width: width / 12,
              //           child: Center(child: Text('1')),
              //           decoration: BoxDecoration(
              //               shape: BoxShape.circle,
              //               border: Border.all(
              //                   color: ColorsThemes.mailColors, width: 1)),
              //         )
              //       ],
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     ),
              //   ),
              // ),
              SliverToBoxAdapter(
                child: InkWell(
                  splashColor: Colors.white,
                  highlightColor: Colors.white,
                  onTap: () {
                    print('${_provider.startTime}');
                    var ddd = (DateTime.now()).toString();
                    List l = ddd.split(' ');
                    print('${l[0]}');
                    DatePicker.showTime12hPicker(context,
                        showTitleActions: true, onChanged: (date) {
                      print('change $date in time zone ' +
                          date.timeZoneOffset.inHours.toString());
                    }, onConfirm: (date) {
                      _provider.setStartTime('${date.hour}:${date.minute}:30');
                    },
                        currentTime:
                            DateTime.parse('${l[0]} ${_provider.startTime}'));
                  },
                  child: Container(
                    height: height / 18,
                    padding:
                        EdgeInsets.only(left: width / 20, right: width / 20),
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
                              color: ColorsThemes.mailColors, fontSize: 15),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: InkWell(
                  splashColor: Colors.white,
                  highlightColor: Colors.white,
                  onTap: () async {
                    List l = _provider.startTime.toString().split(':');
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
                    margin:
                        EdgeInsets.only(left: width / 20, right: width / 20),
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
                              color: ColorsThemes.mailColors, fontSize: 15),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: height / 18,
                  padding: EdgeInsets.only(left: width / 20, right: width / 20),
                  color: ColorsThemes.offGraycolor,
                  child: Row(
                    children: [
                      Text(
                        '5 mins before',
                        style: TextStyle(
                            color: ColorsThemes.lightBlackColor, fontSize: 15),
                      ),
                      Switch(
                        value: _provider.fiveminBefore == true ? true : false,
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
                  margin: EdgeInsets.only(left: width / 20, right: width / 20),
                  child: Row(
                    children: [
                      Text(
                        '5 seconds before',
                        style: TextStyle(
                            color: ColorsThemes.lightBlackColor, fontSize: 15),
                      ),
                      Switch(
                        value: _provider.fiveSecBefore == true ? true : false,
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
                  padding: EdgeInsets.only(left: width / 20, right: width / 20),
                  color: ColorsThemes.offGraycolor,
                  child: Row(
                    children: [
                      Text(
                        'Focus',
                        style: TextStyle(
                            color: ColorsThemes.lightBlackColor, fontSize: 15),
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
                  margin: EdgeInsets.only(left: width / 20, right: width / 20),
                  child: Row(
                    children: [
                      Text(
                        'Bad Habit',
                        style: TextStyle(
                            color: ColorsThemes.lightBlackColor, fontSize: 15),
                      ),
                      Switch(
                        value: _provider.badHabit == true ? true : false,
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
                  margin: EdgeInsets.only(left: width / 20, right: width / 20),
                  child: Row(
                    children: [
                      Text(
                        'Pin Task',
                        style: TextStyle(
                            color: ColorsThemes.lightBlackColor, fontSize: 15),
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
                  padding: EdgeInsets.only(left: width / 20, right: width / 10),
                  color: ColorsThemes.offGraycolor,
                  child: Row(
                    children: [
                      Text(
                        'Color',
                        style: TextStyle(
                            color: ColorsThemes.lightBlackColor, fontSize: 15),
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
                                        duration: Duration(seconds: 1),
                                        child: Container(
                                          padding: EdgeInsets.all(width / 20),
                                          height: height,
                                          width: width,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Icon(
                                                      Icons.arrow_back_ios,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: width / 30,
                                                  ),
                                                  Text(
                                                    'Colors',
                                                    style: TextStyle(
                                                        letterSpacing: 2,
                                                        fontSize: 20),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: height / 30,
                                              ),
                                              Expanded(
                                                  child: ListView.builder(
                                                itemBuilder: (c, i) {
                                                  return Container(
                                                    margin: EdgeInsets.only(
                                                        top: height / 40),
                                                    child: InkWell(
                                                      onTap: () {
                                                        for (var i = 0;
                                                            i <
                                                                _provider
                                                                    .listofColors
                                                                    .length;
                                                            i++) {
                                                          _provider
                                                              .setlistofColorsbool(
                                                                  i, false);
                                                        }
                                                        _provider
                                                            .setlistofColorsbool(
                                                                i, true);
                                                        _provider.setPColors(
                                                            _provider
                                                                .listofColors[i]);
                                                        Navigator.of(context)
                                                            .pop();
                                                        _provider.setColorString(
                                                            _provider
                                                                .listOfColorValue[i]);
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            height: height / 30,
                                                            width: width / 15,
                                                            decoration: BoxDecoration(
                                                                color: _provider
                                                                        .listofColors[
                                                                    i],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                          ),
                                                          SizedBox(
                                                            width: width / 30,
                                                          ),
                                                          Text(
                                                            '${_provider.listofColorstext[i]}',
                                                            style: TextStyle(
                                                                letterSpacing:
                                                                    1,
                                                                fontSize: 12),
                                                          ),
                                                          Expanded(
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: Padding(
                                                                padding: EdgeInsets.only(
                                                                    right:
                                                                        width /
                                                                            20),
                                                                child: Icon(
                                                                  Icons.check,
                                                                  color: _provider.listofColorsbool[
                                                                              i] ==
                                                                          false
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .blue,
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
                                                    .listofColors.length,
                                              )),
                                              SizedBox(
                                                height: height / 30,
                                              ),
                                            ],
                                          ),
                                          margin:
                                              EdgeInsets.only(top: height / 10),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(15),
                                                  topLeft: Radius.circular(15)),
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
                              shape: BoxShape.circle, color: _provider.pcolor),
                        ),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: height / 30,
                ),
              )
            ],
          ),
        ));
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
}

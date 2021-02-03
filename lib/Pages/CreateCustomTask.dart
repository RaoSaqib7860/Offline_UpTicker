import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:upticker/ApiConfig/APiUtil.dart';
import 'package:upticker/ColorsThems/ThemesColors.dart';
import 'package:upticker/Pages/AddCustomTask.dart';
import 'package:upticker/Pages/CreateSubCustomTaskBucket.dart';
import 'package:upticker/Provider/BlockAddCustomTask.dart';
import 'package:upticker/Provider/BlockCalenderList.dart';
import 'package:upticker/Provider/BlockCreateCustomTaskBucket.dart';
import 'package:upticker/Provider/BlockCreateSubCustomTaskBucket.dart';
import 'package:upticker/ServicesForApp/CalendarClient.dart';
import 'package:upticker/ServicesForApp/FireBaseAnalytics.dart';

class CreateCustomTask extends StatefulWidget {
  CreateCustomTask({Key key, this.token}) : super(key: key);
  final token;

  @override
  _CreateCustomTaskState createState() => _CreateCustomTaskState();
}

class _CreateCustomTaskState extends State<CreateCustomTask> {
  @override
  void initState() {
    final BlockCreateCustomTaskBucket _provider =
        Provider.of<BlockCreateCustomTaskBucket>(context, listen: false);
    FireBaseAnalyticsServices.setCurrentScreen(
        screenClass: 'Bucket class', screenName: 'Bucket');
    apiCalling(_provider);
    super.initState();
  }

  apiCalling(BlockCreateCustomTaskBucket provider) async {
    await ApiUtils.getCustomBucketTaskData(provider: provider);
  }

  @override
  Widget build(BuildContext context) {
    final BlockCreateCustomTaskBucket _provider =
        Provider.of<BlockCreateCustomTaskBucket>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              height: height,
              width: width,
              child: Column(
                children: [
                  SizedBox(
                    height: height / 15,
                  ),
                  InkWell(
                    splashColor: Colors.white,
                    highlightColor: Colors.white,
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              duration: Duration(milliseconds: 500),
                              type: PageTransitionType.rightToLeft,
                              child: ChangeNotifierProvider(
                                create: (_) => BlockAddCustomTask(),
                                child: AddCustomTask(),
                              )));
                    },
                    focusColor: Colors.white,
                    hoverColor: Colors.white,
                    child: Container(
                      margin: EdgeInsets.only(
                          left: width / 10,
                          right: width / 10,
                          bottom: height / 30),
                      height: height / 15,
                      width: width,
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.5,
                            color: ColorsThemes.mailColors,
                          ),
                          borderRadius: BorderRadius.circular(7)),
                      child: Center(
                        child: Text(
                          '+ Create Custom Task',
                          style: TextStyle(
                              color: ColorsThemes.mailColors, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: _provider.loading == false
                          ? Center(
                              child: Container(
                                height: height / 10,
                                width: width / 5,
                                child: SpinKitRotatingCircle(
                                  itemBuilder:
                                      (BuildContext context, int index) {
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
                          : ListView.builder(
                              itemBuilder: (c, i) {
                                return InkWell(
                                  splashColor: Colors.white,
                                  highlightColor: Colors.white,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            duration:
                                                Duration(milliseconds: 500),
                                            type:
                                                PageTransitionType.rightToLeft,
                                            child: ChangeNotifierProvider(
                                              create: (_) =>
                                                  BlockCreateSubCustomBucketTask(),
                                              child: CreateCustomSubBucketTask(
                                                id: '${_provider.customBucketData[i]['id']}',
                                              ),
                                            )));
                                  },
                                  child: FlipInY(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: width / 20, right: width / 20),
                                      height: height / 22,
                                      width: width,
                                      decoration: BoxDecoration(
                                          color: i.isOdd
                                              ? Colors.white
                                              : ColorsThemes.offGraycolor),
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
                                                  padding: EdgeInsets.all(
                                                      width / 40),
                                                  child: Image.network(
                                                      '${_provider.customBucketData[i]['icon']}'),
                                                ),
                                                SizedBox(
                                                  width: width / 30,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    '${_provider.customBucketData[i]['name']}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                          Icon(Icons.keyboard_arrow_right,
                                              color:
                                                  ColorsThemes.ringThemeColor),
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
                              itemCount: _provider.customBucketData.length,
                              physics: BouncingScrollPhysics(),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: height / 9,
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                splashColor: Colors.white,
                highlightColor: Colors.white,
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          duration: Duration(milliseconds: 300),
                          type: PageTransitionType.bottomToTop,
                          child: ChangeNotifierProvider(
                            create: (_) => BlockCalenderList(),
                            child: CalenderCalsslist(),
                          )));
                  //  displayBottomSheet(context: context, provider: _provider);
                },
                child: Container(
                  margin: EdgeInsets.only(
                      bottom: height / 30, left: width / 10, right: width / 10),
                  height: height / 15,
                  width: width,
                  decoration: BoxDecoration(
                      color: ColorsThemes.offGraycolor,
                      border: Border.all(
                        width: 1.5,
                        color: ColorsThemes.mailColors,
                      ),
                      borderRadius: BorderRadius.circular(7)),
                  child: Center(
                    child: Text(
                      'Pull Calender',
                      style: TextStyle(
                          color: ColorsThemes.mailColors, fontSize: 15),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(width / 20),
                child: InkWell(
                  splashColor: Colors.white,
                  highlightColor: Colors.white,
                  child: Icon(Platform.isAndroid
                      ? Icons.arrow_back
                      : Icons.arrow_back_ios),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void displayBottomSheet(
      {BuildContext context, BlockCreateCustomTaskBucket provider}) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Container(
            padding: EdgeInsets.all(width / 30),
            height: MediaQuery.of(context).size.height / 5,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        InkWell(
                          splashColor: Colors.white,
                          highlightColor: Colors.white,
                          onTap: () {
                            CalendarClient calendarClient = CalendarClient();
                            calendarClient.insertGoogleCalender(
                                token:
                                    '121705970912-27jjev5pjc5eoa8cj3889egjefthad7c.apps.googleusercontent.com',
                                context: context);
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            padding: EdgeInsets.all(width / 35),
                            height: height / 10,
                            width: width / 5,
                            child: Image.asset('assets/google.png'),
                          ),
                        ),
                        Text(
                          'Google',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Comfortaa',
                              letterSpacing: 0.3,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: width / 20,
                    ),
                    Column(
                      children: [
                        InkWell(
                          splashColor: Colors.white,
                          highlightColor: Colors.white,
                          onTap: () {
                            CalendarClient calendarClient = CalendarClient();
                            calendarClient.fetchOutlookCalender(
                                context: context);
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            padding: EdgeInsets.all(width / 35),
                            height: height / 10,
                            width: width / 5,
                            child: Image.asset('assets/outlook.png'),
                          ),
                        ),
                        Text(
                          'Outlook',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Comfortaa',
                              letterSpacing: 0.3,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          );
        });
  }
}

class CalenderCalsslist extends StatefulWidget {
  CalenderCalsslist({Key key}) : super(key: key);

  @override
  _CalenderCalsslistState createState() => _CalenderCalsslistState();
}

class _CalenderCalsslistState extends State<CalenderCalsslist> {
  @override
  void initState() {
    final _provider = Provider.of<BlockCalenderList>(context, listen: false);
    getApiData(_provider);
    FireBaseAnalyticsServices.setCurrentScreen(
        screenClass: 'Calender Events class', screenName: 'Calender Events');
    super.initState();
  }

  getApiData(BlockCalenderList provider) async {
    await ApiUtils.getClaenderlist(
        provider: provider, scaffoldkey: provider.scaffoldKey);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final _provider = Provider.of<BlockCalenderList>(context);

    return SafeArea(
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
                      margin:
                          EdgeInsets.only(left: width / 10, right: width / 10),
                      height: double.infinity,
                      width: double.infinity,
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.only(top: height / 30),
                          child: Text(
                            'Calender',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                                letterSpacing: 0.3),
                          ),
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
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              left: width / 30, top: height / 30),
                          height: height / 14,
                          width: width / 7,
                          child: Center(
                            child: Icon(
                              Platform.isAndroid
                                  ? Icons.arrow_back
                                  : Icons.arrow_back_ios,
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
          padding: EdgeInsets.all(width / 20),
          child: Column(
            children: [
              Text(
                'Add Calander',
                style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 20,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: height / 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      InkWell(
                        splashColor: Colors.white,
                        highlightColor: Colors.white,
                        onTap: () {
                          if (_provider.loading == true) {
                            if (_provider.google == false) {
                              CalendarClient calendarClient = CalendarClient();
                              calendarClient.insertGoogleCalender(
                                  token:
                                      '121705970912-27jjev5pjc5eoa8cj3889egjefthad7c.apps.googleusercontent.com',
                                  context: context);
                              Navigator.of(context).pop();
                            }
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(width / 35),
                          height: height / 10,
                          width: width / 5,
                          child: Image.asset('assets/google.png'),
                        ),
                      ),
                      Text(
                        'Google',
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Comfortaa',
                            letterSpacing: 0.3,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: width / 20,
                  ),
                  Column(
                    children: [
                      InkWell(
                        splashColor: Colors.white,
                        highlightColor: Colors.white,
                        onTap: () {
                          if (_provider.loading == true) {
                            if (_provider.outlook == false) {
                              CalendarClient calendarClient = CalendarClient();
                              calendarClient.fetchOutlookCalender();
                              Navigator.of(context).pop();
                            }
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(width / 35),
                          height: height / 10,
                          width: width / 5,
                          child: Image.asset(
                            'assets/outlook.png',
                          ),
                        ),
                      ),
                      Text(
                        'Outlook',
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Comfortaa',
                            letterSpacing: 0.3,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: height / 20,
              ),
              Text(
                'Attached calander ',
                style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 20,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w300),
              ),
              Expanded(
                  child: _provider.loading == false
                      ? Center(
                          child: CupertinoActivityIndicator(
                            animating: true,
                          ),
                        )
                      : ListView.builder(
                          itemBuilder: (c, i) {
                            if (_provider.listofcal[i]['platform'] ==
                                'outlook') {
                              _provider.setoutlook(true);
                            }

                            if (_provider.listofcal[i]['platform'] ==
                                'google') {
                              _provider.setgoogle(true);
                            }

                            return Container(
                              margin: EdgeInsets.only(top: height / 30),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 2,
                                        spreadRadius: 5,
                                        color: Colors.black12)
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      _provider.listofcal[i]['platform'] ==
                                              'outlook'
                                          ? Container(
                                              padding:
                                                  EdgeInsets.all(width / 35),
                                              height: height / 14,
                                              width: width / 7,
                                              child: Image.asset(
                                                  'assets/outlook.png'),
                                            )
                                          : Container(
                                              padding:
                                                  EdgeInsets.all(width / 35),
                                              height: height / 14,
                                              width: width / 7,
                                              child: Image.asset(
                                                  'assets/google.png'),
                                            ),
                                      SizedBox(
                                        width: width / 30,
                                      ),
                                      Text(
                                        '${_provider.listofcal[i]['name']}',
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.7),
                                          fontSize: 15,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                      icon: Icon(Icons.delete_outline,
                                          color: Colors.red[200]),
                                      onPressed: () {
                                        if (_provider.listofcal[i]
                                                ['platform'] ==
                                            'outlook') {
                                          _provider.setoutlook(false);
                                        }

                                        if (_provider.listofcal[i]
                                                ['platform'] ==
                                            'google') {
                                          _provider.setgoogle(false);
                                        }

                                        ApiUtils.deleteClaenderlist(
                                            id: _provider.listofcal[i]['id'],
                                            index: i,
                                            provider: _provider);
                                      })
                                ],
                              ),
                              padding: EdgeInsets.all(width / 30),
                            );
                          },
                          itemCount: _provider.listofcal.length,
                        ))
            ],
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ),
      ),
    );
  }
}

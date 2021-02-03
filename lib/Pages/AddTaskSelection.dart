import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:upticker/ColorsThems/ThemesColors.dart';
import 'package:upticker/Provider/BlockAddAditionalMentorTask.dart';
import 'package:upticker/Provider/BlockAddCustomTask.dart';
import 'package:upticker/Provider/BlockCalenderList.dart';
import 'package:upticker/Provider/BlockCreateCustomTaskBucket.dart';
import 'package:upticker/ServicesForApp/CalendarClient.dart';
import 'package:upticker/ServicesForApp/FireBaseAnalytics.dart';
import 'AddAditionalMentorsTask.dart';
import 'AddCustomTask.dart';
import 'CreateCustomTask.dart';

class AddTaskSelection extends StatefulWidget {
  AddTaskSelection({Key key}) : super(key: key);

  @override
  _AddTaskSelectionState createState() => _AddTaskSelectionState();
}

class _AddTaskSelectionState extends State<AddTaskSelection> {
  @override
  void initState() {
    FireBaseAnalyticsServices.setCurrentScreen(
        screenClass: 'Bucket or Mentor selection class',
        screenName: 'Bucket or Mentor selection');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  InkWell(
                    splashColor: Colors.white,
                    highlightColor: Colors.white,
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              duration: Duration(milliseconds: 300),
                              type: PageTransitionType.rightToLeft,
                              child: ChangeNotifierProvider(
                                create: (_) => BlockCreateCustomTaskBucket(),
                                child: CreateCustomTask(),
                              )));
                    },
                    child: ElasticInUp(
                      delay: Duration(milliseconds: 500),
                      child: Container(
                        padding: EdgeInsets.only(
                            left: width / 20, right: width / 20),
                        height: height / 22,
                        width: width,
                        decoration:
                            BoxDecoration(color: ColorsThemes.offGraycolor),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: width / 20,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Buckets',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 12,
                                          letterSpacing: 0.5,
                                          color: ColorsThemes.lightBlackColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.keyboard_arrow_right,
                                color: ColorsThemes.ringThemeColor),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.white,
                    highlightColor: Colors.white,
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              duration: Duration(milliseconds: 300),
                              type: PageTransitionType.rightToLeft,
                              child: ChangeNotifierProvider(
                                create: (_) => BlockAditionalMentorTask(),
                                child: AddAditionalMentorTask(),
                              )));
                    },
                    child: ElasticInUp(
                      delay: Duration(milliseconds: 500),
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: width / 20,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Mentors',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 12,
                                          letterSpacing: 0.5,
                                          color: ColorsThemes.lightBlackColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.keyboard_arrow_right,
                                color: ColorsThemes.ringThemeColor),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                        ),
                      ),
                    ),
                  ),
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

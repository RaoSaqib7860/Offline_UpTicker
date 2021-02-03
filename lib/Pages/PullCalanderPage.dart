import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:upticker/ApiConfig/APiUtil.dart';
import 'package:upticker/ColorsThems/ThemesColors.dart';
import 'package:upticker/Provider/BlockFinalHomePage.dart';
import 'package:upticker/Provider/BlockPullCalender.dart';
import 'package:upticker/ServicesForApp/CalendarClient.dart';
import 'package:upticker/ServicesForApp/FireBaseAnalytics.dart';
import 'FinalHomePage.dart';

class PullCalenderPage extends StatefulWidget {
  static PullCalenderBlock provider;

  PullCalenderPage({Key key, this.isafter}) : super(key: key);
  final bool isafter;

  @override
  _PullCalenderPageState createState() => _PullCalenderPageState();
}

class _PullCalenderPageState extends State<PullCalenderPage> {
  bool anim = false;

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        anim = true;
      });
    });
    final _provider = Provider.of<PullCalenderBlock>(context, listen: false);
    getApiData(provider: _provider, isafter: widget.isafter);
    FireBaseAnalyticsServices.setCurrentScreen(
        screenName: 'Add Calendar', screenClass: 'Add Calendar class');
    super.initState();
  }

  getApiData({PullCalenderBlock provider, bool isafter}) async {
    await ApiUtils.getClaenderlistforStart(
        isafter: isafter,
        provider: provider,
        scaffoldkey: provider.scaffoldKey);
  }

  Future<bool> onbackPres() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<PullCalenderBlock>(context);
    PullCalenderPage.provider = _provider;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: onbackPres,
      child: SafeArea(
        child: Scaffold(
          key: _provider.scaffoldKey,
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Container(
                height: height,
                width: width,
                padding: EdgeInsets.only(left: width / 20, right: width / 20),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: height / 10),
                      child: Text(
                        'Add Calendar Events',
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.7), fontSize: 25),
                      ),
                    ),
                    SizedBox(
                      height: height / 20,
                    ),
                    InkWell(
                      onTap: () {
                        displayBottomSheet(
                            context: context, provider: _provider);
                      },
                      child: Container(
                        height: height / 4,
                        width: width / 2,
                        child: Center(
                          child: Text(
                            'Link Calendar',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(.11),
                                offset: Offset(
                                  -3.0,
                                  -3.0,
                                ),
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(.11),
                                offset: Offset(
                                  4.0,
                                  4.0,
                                ),
                              ),
                            ],
                            color: ColorsThemes.mailColors,
                            shape: BoxShape.circle),
                      ),
                    ),
                    SizedBox(
                      height: height / 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _provider.loading == true
                            ? _provider.listofcal.length > 0
                                ? 'Attached calander '
                                : ''
                            : '',
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontSize: 20,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    SizedBox(
                      height: height / 150,
                    ),
                    Expanded(
                        child: _provider.loading == false
                            ? Center()
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
                                            _provider.listofcal[i]
                                                        ['platform'] ==
                                                    'outlook'
                                                ? Container(
                                                    padding: EdgeInsets.all(
                                                        width / 35),
                                                    height: height / 18,
                                                    width: width / 7,
                                                    child: Image.asset(
                                                        'assets/outlook.png'),
                                                  )
                                                : Container(
                                                    padding: EdgeInsets.all(
                                                        width / 35),
                                                    height: height / 18,
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
                                                color: Colors.black
                                                    .withOpacity(0.7),
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

                                              ApiUtils
                                                  .deleteClaenderlistforpullCalender(
                                                      id: _provider.listofcal[i]
                                                          ['id'],
                                                      index: i,
                                                      provider: _provider);
                                            })
                                      ],
                                    ),
                                    padding: EdgeInsets.all(width / 30),
                                  );
                                },
                                itemCount: _provider.listofcal.length,
                              )),
                    SizedBox(
                      height: height / 20,
                    )
                  ],
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
              ),
              AnimatedAlign(
                curve: Curves.bounceOut,
                alignment: anim == false
                    ? Alignment.bottomLeft
                    : Alignment.bottomRight,
                duration: Duration(milliseconds: 800),
                child: InkWell(
                  splashColor: Colors.white,
                  highlightColor: Colors.white,
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      PageTransition(
                          duration: Duration(milliseconds: 500),
                          type: PageTransitionType.rightToLeft,
                          child: ChangeNotifierProvider(
                            create: (_) => BlockFinalHomePage(),
                            child: FinalHomePageClass(),
                          )),
                      ModalRoute.withName('/'),
                    );
                  },
                  child: Container(
                    height: height / 20,
                    width: width / 4,
                    child: Center(
                      child: Text(
                        _provider.iscalender == true ? 'Next' : 'Skip',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    margin: EdgeInsets.all(width / 20),
                    decoration: BoxDecoration(
                        color: ColorsThemes.mailColors,
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              _provider.isredirect == false
                  ? SizedBox()
                  : Container(
                      height: height,
                      width: width,
                      child: Center(
                        child: InkWell(
                          splashColor: Colors.white,
                          highlightColor: Colors.white,
                          onTap: () {
                            getApiData(provider: _provider, isafter: true);
                            _provider.setisredirect(false);
                          },
                          child: Container(
                            child: Center(
                              child: Text(
                                'Page Refresh',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                            decoration:
                                BoxDecoration(color: ColorsThemes.mailColors),
                            height: height / 18,
                            width: width / 3,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                      ))
            ],
          ),
        ),
      ),
    );
  }

  void displayBottomSheet({BuildContext context, PullCalenderBlock provider}) {
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
                            if (provider.loading == true) {
                              if (provider.google == false) {
                                Navigator.of(context).pop();

                                CalendarClient calendarClient =
                                    CalendarClient();
                                calendarClient.insertGoogleCalender(
                                    token:
                                        '121705970912-27jjev5pjc5eoa8cj3889egjefthad7c.apps.googleusercontent.com',
                                    context: context,
                                    isfirst: true);
                              } else {
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
                            if (provider.loading == true) {
                              if (provider.outlook == false) {
                                Navigator.of(context).pop();
                                CalendarClient calendarClient =
                                    CalendarClient();
                                calendarClient.fetchOutlookCalender();
                              } else {
                                Navigator.of(context).pop();
                              }
                            }
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

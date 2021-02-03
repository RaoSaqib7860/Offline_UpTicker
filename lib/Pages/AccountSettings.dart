import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:upticker/ApiConfig/APiUtil.dart';
import 'package:upticker/ColorsThems/ThemesColors.dart';
import 'package:upticker/Pages/ManageAccount.dart';
import 'package:upticker/Pages/NotificationSound.dart';
import 'package:upticker/Provider/BlockManageAccount.dart';
import 'package:upticker/Provider/BlockNotificationSound.dart';
import 'package:upticker/Provider/LoginBlock.dart';
import 'package:upticker/ServicesForApp/FireBaseAnalytics.dart';
import 'package:upticker/SharedPreference/SharedPreference.dart';
import 'package:upticker/main.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ContactUs.dart';
import 'Login.dart';

class AccountSettingsPage extends StatefulWidget {
  AccountSettingsPage({Key key}) : super(key: key);

  @override
  _AccountSettingsPageState createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  FirebaseAnalyticsObserver observer;
  FirebaseAnalytics analytics;
  bool isSwitched;

  bool isgood;
  bool issmashed;
  bool great;
  bool stayStrong;

  @override
  void initState() {
    isSwitched = ApiUtils.notifications == 'true' ? true : false;
    isgood = ApiUtils.pop_up == 'good' ? true : false;
    issmashed = ApiUtils.pop_up == 'smashed it' ? true : false;
    great = ApiUtils.pop_up == 'great' ? true : false;
    stayStrong = ApiUtils.pop_up == 'stay strong' ? true : false;
    _testSetCurrentScreen();
    FireBaseAnalyticsServices.setCurrentScreen(
        screenName: 'Account Settings', screenClass: 'Account Settings class');
    super.initState();
  }

  Future<void> _testSetCurrentScreen() async {
    await MyApp.analytics.setCurrentScreen(
      screenName: 'User Setting page',
      screenClassOverride: 'UpTicker Analytics',
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SwipeDetector(
      onSwipeRight: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
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
                            'Settings',
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
                              Icons.arrow_back_ios,
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
          child: ListView(
            children: [
              SizedBox(
                height: height / 30,
              ),
              // InkWell(
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         PageTransition(
              //             duration: Duration(milliseconds: 500),
              //             type: PageTransitionType.rightToLeft,
              //             child: ChangeNotifierProvider(
              //                 create: (BuildContext context) =>
              //                     BlockMangeAccount(),
              //                 child: ManageAccount())));
              //   },
              //   child: Container(
              //     height: height / 18,
              //     margin: EdgeInsets.only(left: width / 15, right: width / 15),
              //     child: Row(
              //       children: [
              //         Text(
              //           'Manage Account',
              //           style: TextStyle(
              //               color: ColorsThemes.lightBlackColor, fontSize: 15),
              //         ),
              //       ],
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     ),
              //   ),
              // ),
              // Container(
              //   height: height / 18,
              //   padding: EdgeInsets.only(left: width / 15, right: width / 15),
              //   color: ColorsThemes.offGraycolor,
              //   child: Row(
              //     children: [
              //       Text(
              //         'Alarm',
              //         style: TextStyle(
              //             color: ColorsThemes.lightBlackColor, fontSize: 15),
              //       ),
              //       // Switch(
              //       //   value: isSwitched,
              //       //   onChanged: (value) {
              //       //     setState(() {
              //       //       isSwitched = value;
              //       //       print(isSwitched);
              //       //     });
              //       //   },
              //       //   activeTrackColor: ColorsThemes.ringThemeColor,
              //       //   activeColor: ColorsThemes.mailColors,
              //       // ),
              //     ],
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   ),
              // ),
              // Container(
              //   height: height / 20,
              //   padding: EdgeInsets.only(left: width / 15, right: width / 15),
              //   color: ColorsThemes.offGraycolor,
              //   child: Row(
              //     children: [
              //       Text(
              //         'Notifications Sound',
              //         style: TextStyle(
              //             color: ColorsThemes.lightBlackColor, fontSize: 15),
              //       ),
              //     ],
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   ),
              // ),
              // SizedBox(height: height / 50),
              // Container(
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       InkWell(
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               '  5 min notification',
              //               style: TextStyle(
              //                   color: ColorsThemes.lightBlackColor,
              //                   fontSize: 15),
              //             ),
              //             Text(
              //               '${ApiUtils.five_minute_sound}',
              //               style: TextStyle(color: ColorsThemes.mailColors, fontSize: 15),
              //             ),
              //           ],
              //         ),
              //         onTap: () {
              //           Navigator.push(
              //               context,
              //               PageTransition(
              //                 duration: Duration(milliseconds: 500),
              //                 type: PageTransitionType.rightToLeft,
              //                 child: ChangeNotifierProvider(
              //                     create: (_) => BlockNotificationSound(),
              //                     child: NotificationSound(
              //                       text: '5 min notification',
              //                       tag: '${ApiUtils.five_minute_sound}',
              //                     )),
              //               ));
              //         },
              //       ),
              //       SizedBox(height: height / 60),
              //       InkWell(
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               '  5 sec notification',
              //               style: TextStyle(
              //                   color: ColorsThemes.lightBlackColor,
              //                   fontSize: 15),
              //             ),
              //             Text(
              //               '${ApiUtils.five_second_sound}',
              //               style: TextStyle(color: ColorsThemes.mailColors, fontSize: 15),
              //             ),
              //           ],
              //         ),
              //         onTap: () {
              //           Navigator.push(
              //               context,
              //               PageTransition(
              //                 duration: Duration(milliseconds: 500),
              //                 type: PageTransitionType.rightToLeft,
              //                 child: ChangeNotifierProvider(
              //                     create: (_) => BlockNotificationSound(),
              //                     child: NotificationSound(
              //                         text: '5 sec notification',
              //                         tag: '${ApiUtils.five_second_sound}')),
              //               ));
              //         },
              //       ),
              //       SizedBox(height: height / 60),
              //       InkWell(
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               '  Complete',
              //               style: TextStyle(
              //                   color: ColorsThemes.lightBlackColor,
              //                   fontSize: 15),
              //             ),
              //             Text(
              //               '${ApiUtils.complete_sound}',
              //               style: TextStyle(color: ColorsThemes.mailColors, fontSize: 15),
              //             ),
              //           ],
              //         ),
              //         onTap: () {
              //           Navigator.push(
              //               context,
              //               PageTransition(
              //                 duration: Duration(milliseconds: 500),
              //                 type: PageTransitionType.rightToLeft,
              //                 child: ChangeNotifierProvider(
              //                     create: (_) => BlockNotificationSound(),
              //                     child: NotificationSound(
              //                         text: 'Complete',
              //                         tag: '${ApiUtils.complete_sound}')),
              //               ));
              //         },
              //       ),
              //     ],
              //   ),
              //   padding: EdgeInsets.only(left: width / 10, right: width / 15),
              // ),
              // SizedBox(
              //   height: height / 30,
              // ),
              // Container(
              //   height: height / 18,
              //   padding: EdgeInsets.only(left: width / 15, right: width / 15),
              //   color: ColorsThemes.offGraycolor,
              //   child: Row(
              //     children: [
              //       Text(
              //         'Only "good" message',
              //         style: TextStyle(
              //             color: ColorsThemes.lightBlackColor, fontSize: 15),
              //       ),
              //       // Switch(
              //       //   value: isSwitched,
              //       //   onChanged: (value) {
              //       //     setState(() {
              //       //       isSwitched = value;
              //       //       print(isSwitched);
              //       //     });
              //       //   },
              //       //   activeTrackColor: ColorsThemes.ringThemeColor,
              //       //   activeColor: ColorsThemes.mailColors,
              //       // ),
              //     ],
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   ),
              // ),
              // Container(
              //   height: height / 18,
              //   padding: EdgeInsets.only(left: width / 15, right: width / 15),
              //   child: Row(
              //     children: [
              //       Text(
              //         'Siri & Shortcuts',
              //         style: TextStyle(
              //             color: ColorsThemes.lightBlackColor, fontSize: 15),
              //       ),
              //     ],
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   ),
              // ),
              // Container(
              //   height: height / 18,
              //   padding: EdgeInsets.only(left: width / 15, right: width / 15),
              //   color: ColorsThemes.offGraycolor,
              //   child: Row(
              //     children: [
              //       Text(
              //         'Change Email',
              //         style: TextStyle(
              //             color: ColorsThemes.lightBlackColor, fontSize: 15),
              //       ),
              //     ],
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   ),
              // ),
              // Container(
              //   height: height / 18,
              //   padding: EdgeInsets.only(left: width / 15, right: width / 15),
              //   child: Row(
              //     children: [
              //       Text(
              //         'Applications & Devices',
              //         style: TextStyle(
              //             color: ColorsThemes.lightBlackColor, fontSize: 15),
              //       ),
              //     ],
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   ),
              // ),
              // Container(
              //   height: height / 18,
              //   padding: EdgeInsets.only(left: width / 15, right: width / 15),
              //   color: ColorsThemes.offGraycolor,
              //   child: Row(
              //     children: [
              //       Text(
              //         'Forgot Password',
              //         style: TextStyle(
              //             color: ColorsThemes.lightBlackColor, fontSize: 15),
              //       ),
              //     ],
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   ),
              // ),
              Container(
                height: height / 18,
                padding: EdgeInsets.only(left: width / 15, right: width / 15),
                color: ColorsThemes.offGraycolor,
                child: Row(
                  children: [
                    Text(
                      'Pop up message',
                      style: TextStyle(
                          color: ColorsThemes.lightBlackColor, fontSize: 15),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ),
              SizedBox(height: height / 100),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '  Good',
                          style: TextStyle(
                              color: ColorsThemes.lightBlackColor,
                              fontSize: 15),
                        ),
                        Checkbox(
                            activeColor: ColorsThemes.mailColors,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            value: isgood,
                            onChanged: (bool istrue) {
                              setState(() {
                                isgood = true;
                                issmashed = false;
                                great = false;
                                stayStrong = false;
                              });
                              ApiUtils.UpdateUserData(
                                  key: 'pop_up', description: 'good');
                              SharedPreferenceClass.addpop_up('good');
                              ApiUtils.pop_up = 'good';
                            })
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '  Smashed It!',
                          style: TextStyle(
                              color: ColorsThemes.lightBlackColor,
                              fontSize: 15),
                        ),
                        Checkbox(
                            activeColor: ColorsThemes.mailColors,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            value: issmashed,
                            onChanged: (bool istrue) {
                              setState(() {
                                isgood = false;
                                issmashed = true;
                                great = false;
                                stayStrong = false;
                              });
                              ApiUtils.UpdateUserData(
                                  key: 'pop_up', description: 'smashed it');
                              SharedPreferenceClass.addpop_up('smashed it');
                              ApiUtils.pop_up = 'smashed it';
                            })
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '  Great!',
                          style: TextStyle(
                              color: ColorsThemes.lightBlackColor,
                              fontSize: 15),
                        ),
                        Checkbox(
                            activeColor: ColorsThemes.mailColors,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            value: great,
                            onChanged: (bool istrue) {
                              setState(() {
                                isgood = false;
                                issmashed = false;
                                great = true;
                                stayStrong = false;
                              });
                              ApiUtils.UpdateUserData(
                                  key: 'pop_up', description: 'great');
                              SharedPreferenceClass.addpop_up('great');
                              ApiUtils.pop_up = 'great';
                            })
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '  Stay Strong',
                          style: TextStyle(
                              color: ColorsThemes.lightBlackColor,
                              fontSize: 15),
                        ),
                        Checkbox(
                            activeColor: ColorsThemes.mailColors,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            value: stayStrong,
                            onChanged: (bool istrue) {
                              setState(() {
                                isgood = false;
                                issmashed = false;
                                great = false;
                                stayStrong = true;
                              });
                              ApiUtils.UpdateUserData(
                                  key: 'pop_up', description: 'stay strong');
                              SharedPreferenceClass.addpop_up('stay strong');
                              ApiUtils.pop_up = 'stay strong';
                            })
                      ],
                    ),
                  ],
                ),
                padding: EdgeInsets.only(left: width / 10, right: width / 15),
              ),
              SizedBox(height: height / 100),
              Container(
                height: height / 18,
                color: ColorsThemes.offGraycolor,
                padding: EdgeInsets.only(left: width / 15, right: width / 15),
                child: Row(
                  children: [
                    Text(
                      'Notifications',
                      style: TextStyle(
                          color: ColorsThemes.lightBlackColor, fontSize: 15),
                    ),
                    Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                          print(isSwitched);
                        });
                        ApiUtils.UpdateUserData(
                            key: 'notifications', description: '$value');
                        SharedPreferenceClass.addnotifications('$value');
                        ApiUtils.notifications = '$value';
                      },
                      activeTrackColor: ColorsThemes.ringThemeColor,
                      activeColor: ColorsThemes.mailColors,
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (c) => ContactUs()));
                },
                child: Container(
                  height: height / 18,
                  margin: EdgeInsets.only(left: width / 15, right: width / 15),
                  child: Row(
                    children: [
                      Text(
                        'Contact Us',
                        style: TextStyle(
                            color: ColorsThemes.lightBlackColor, fontSize: 15),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ),
              ),
              Container(
                height: height / 18,
                padding: EdgeInsets.only(left: width / 15, right: width / 15),
                color: ColorsThemes.offGraycolor,
                child: InkWell(
                  onTap: () {
                    SharedPreferenceClass.removeValues();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              ChangeNotifierProvider(
                                create: (_) => BlockLogin(),
                                child: LoginPage(),
                              )),
                      ModalRoute.withName('/'),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sign Out',
                        style: TextStyle(color: Colors.red, fontSize: 15),
                      ),
                      Icon(
                        Icons.backspace_outlined,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height / 40,
              ),
              InkWell(
                onTap: () {
                  launchURL('https://www.uptickerapp.com/net-zero');
                },
                child: Container(
                  height: height / 30,
                  margin: EdgeInsets.only(left: width / 15, right: width / 15),
                  child: Row(
                    children: [
                      Text(
                        'Net Zero',
                        style: TextStyle(color: Colors.blue, fontSize: 15),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  launchURL('https://www.uptickerapp.com/terms-of-use');
                },
                child: Container(
                  height: height / 30,
                  margin: EdgeInsets.only(left: width / 15, right: width / 15),
                  child: Row(
                    children: [
                      Text(
                        'Terms of Use',
                        style: TextStyle(color: Colors.blue, fontSize: 15),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  launchURL('https://www.uptickerapp.com/privacy-policy');
                },
                child: Container(
                  height: height / 30,
                  margin: EdgeInsets.only(left: width / 15, right: width / 15),
                  child: Row(
                    children: [
                      Text(
                        'Privacy policy',
                        style: TextStyle(color: Colors.blue, fontSize: 15),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  launchURL('https://www.uptickerapp.com/security-policy');
                },
                child: Container(
                  height: height / 30,
                  margin: EdgeInsets.only(left: width / 15, right: width / 15),
                  child: Row(
                    children: [
                      Text(
                        'Security policy',
                        style: TextStyle(color: Colors.blue, fontSize: 15),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  launchURL('https://www.uptickerapp.com/csr');
                },
                child: Container(
                  height: height / 30,
                  margin: EdgeInsets.only(left: width / 15, right: width / 15),
                  child: Row(
                    children: [
                      Text(
                        'CSR',
                        style: TextStyle(color: Colors.blue, fontSize: 15),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ),
              ),
              SizedBox(
                height: height / 50,
              ),
              Container(
                height: height / 30,
                margin: EdgeInsets.only(left: width / 15, right: width / 15),
                child: Row(
                  children: [
                    Text(
                      'Version 1.0.1',
                      style: TextStyle(color: Colors.black38, fontSize: 11),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
              SizedBox(
                height: height / 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  launchURL(String urls) async {
    var url = '$urls';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

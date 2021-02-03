import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:upticker/ApiConfig/APiUtil.dart';
import 'package:upticker/ColorsThems/ThemesColors.dart';
import 'package:upticker/Provider/BlockFeedBack.dart';
import 'package:upticker/Provider/BlockFinalHomePage.dart';
import 'package:upticker/ServicesForApp/FireBaseAnalytics.dart';
import 'package:url_launcher/url_launcher.dart';

import 'FinalHomePage.dart';
import 'Login.dart';

class FeedBackPage extends StatefulWidget {
  FeedBackPage({Key key}) : super(key: key);

  @override
  _FeedBackPageState createState() => _FeedBackPageState();
}

class _FeedBackPageState extends State<FeedBackPage> {
  @override
  void initState() {
    FireBaseAnalyticsServices.setCurrentScreen(
        screenName: 'Feed back', screenClass: 'Feed back class');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final BlockFeedBack _provider = Provider.of<BlockFeedBack>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        key: _provider.scaffoldKey,
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(height / 6.3),
          child: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(color: Colors.white),
              margin: EdgeInsets.only(),
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
                            'Feedback',
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
              Align(
                alignment: Alignment.center,
                child: Text(
                  'If you\'d like to report a bug or issue, the best',
                  style: TextStyle(color: ColorsThemes.lightBlackColor),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'way to solve the problem is to contact us',
                  style: TextStyle(color: ColorsThemes.lightBlackColor),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'here so we can fix it for you.',
                  style: TextStyle(color: ColorsThemes.lightBlackColor),
                ),
              ),
              SizedBox(
                height: height / 40,
              ),
              Container(
                margin: EdgeInsets.only(left: width / 10, right: width / 10),
                height: height / 4,
                width: width,
                decoration: BoxDecoration(
                    color: ColorsThemes.offGraycolor,
                    borderRadius: BorderRadius.circular(8)),
                child: TextFormField(
                  maxLines: 9,
                  onChanged: (value) {
                    if (_provider.istext == true) {
                      _provider.setisText(false);
                    }
                  },
                  textInputAction: TextInputAction.done,
                  controller: _provider.nameCon,
                  decoration: InputDecoration(
                      hintText: 'Enter issue here',
                      hintStyle: TextStyle(fontSize: 14),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(width / 30)),
                ),
              ),
              SizedBox(
                height: height / 100,
              ),
              _provider.istext == true
                  ? SizedBox(
                      height: height / 100,
                    )
                  : SizedBox(),
              _provider.istext == true
                  ? Container(
                      margin:
                          EdgeInsets.only(left: width / 10, right: width / 10),
                      child: Text(
                        'Please enter issue',
                        style: TextStyle(fontSize: 9, color: Colors.red),
                      ),
                    )
                  : SizedBox(),
              SizedBox(
                height: height / 50,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      _provider.onVideoButtonPressed();
                    },
                    child: Container(
                      height: height / 30,
                      width: width / 4,
                      child: Center(
                        child: Text('Attach file',
                            style:
                                TextStyle(fontSize: 12, color: Colors.white)),
                      ),
                      decoration: BoxDecoration(
                          color: ColorsThemes.mailColors,
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                  SizedBox(
                    width: width / 30,
                  ),
                  _provider.videofile != null
                      ? Container(
                          child: Text(
                            'One file selected',
                            style: TextStyle(fontSize: 9, color: Colors.blue),
                          ),
                        )
                      : SizedBox()
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              SizedBox(
                height: height / 50,
              ),
              InkWell(
                onTap: () {
                  if (_provider.nameCon.text.isNotEmpty) {
                    ApiUtils.postFeedBack(provider: _provider);
                    showSuccessDailog(context);
                  } else {
                    _provider.setisText(true);
                  }
                },
                child: Container(
                  height: height / 14,
                  margin: EdgeInsets.only(left: width / 10, right: width / 10),
                  width: width,
                  child: Center(
                      child: Text(
                    'Send Feedback',
                    style: TextStyle(color: Colors.white),
                  )),
                  decoration: BoxDecoration(
                      color: ColorsThemes.mailColors,
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              SizedBox(
                height: height / 30,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Enjoying UpTicker?',
                  style: TextStyle(color: ColorsThemes.lightBlackColor),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Help spread the word with a quick 5',
                  style: TextStyle(color: ColorsThemes.lightBlackColor),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'star review on the App store.',
                  style: TextStyle(color: ColorsThemes.lightBlackColor),
                ),
              ),
              SizedBox(
                height: height / 20,
              ),
              InkWell(
                onTap: () {
                  launchURL(
                    Platform.isIOS
                        ? 'https://apps.apple.com/gb/app/upticker/id1542230794'
                        : 'https://play.google.com/store/apps/details?id=com.epochs.upticker',
                  );
                },
                child: Container(
                  height: height / 14,
                  margin: EdgeInsets.only(left: width / 10, right: width / 10),
                  width: width,
                  child: Center(
                      child: Text(
                    'Rate UpTicker',
                    style: TextStyle(color: Colors.white),
                  )),
                  decoration: BoxDecoration(
                      color: ColorsThemes.mailColors,
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showSuccessDailog(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: SingleChildScrollView(
                child: FadeIn(
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                width: width,
                padding: EdgeInsets.all(width / 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: height / 80,
                    ),
                    Text(
                      'Thank you very much for providing feedback. We take action to quickly resolve your issues. We will be in touch shortly with an update.',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: height / 30,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            PageTransition(
                                duration: Duration(milliseconds: 800),
                                type: PageTransitionType.rightToLeft,
                                child: ChangeNotifierProvider(
                                  create: (_) => BlockFinalHomePage(),
                                  child: FinalHomePageClass(),
                                )),
                            ModalRoute.withName('/'),
                          );
                        },
                        child: Container(
                          height: height / 25,
                          width: width / 4,
                          child: Center(
                            child: Text(
                              'Ok',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: ColorsThemes.mailColors,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )),
          );
        });
  }

  void displayBottomSheet(
      BuildContext context, BlockFeedBack provider, bool isimage) {
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
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            provider.onImageButtonPressed(ImageSource.camera,
                                context: context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(width / 100),
                            height: height / 10,
                            width: width / 5,
                            child: Image.asset('assets/camera.png'),
                          ),
                        ),
                        Text(
                          'Camera',
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
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            provider.onImageButtonPressed(ImageSource.gallery,
                                context: context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(width / 35),
                            height: height / 10,
                            width: width / 5,
                            child: Image.asset('assets/gallary.png'),
                          ),
                        ),
                        Text(
                          'Gallary',
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

  launchURL(String urls) async {
    var url = '$urls';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

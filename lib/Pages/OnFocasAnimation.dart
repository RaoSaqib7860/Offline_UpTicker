import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:upticker/ColorsThems/ThemesColors.dart';
import 'package:upticker/Pages/Excercise2WithAnim.dart';
import 'package:upticker/Provider/BlockExcercise2.dart';
import 'package:upticker/ServicesForApp/FireBaseAnalytics.dart';

class OnFocusAnimationPage extends StatefulWidget {
  OnFocusAnimationPage(
      {Key key,
      this.id,
      this.audio,
      this.animation,
      this.taskName,
      this.min,
      this.carasolList})
      : super(key: key);
  final String id;
  final String audio;
  final String animation;
  final String taskName;
  final List carasolList;
  final min;

  @override
  _OnFocusAnimationPageState createState() => _OnFocusAnimationPageState();
}

class _OnFocusAnimationPageState extends State<OnFocusAnimationPage> {
  bool anim = false;
  int number = 3;
  int numm = 3;
  String text = 'Remember to Stay Present';
  bool navigation = false;
  Timer timer;

  @override
  void initState() {
    Stream<int> stream =
        Stream<int>.periodic(Duration(seconds: 2), (x) => x).take(3);
    stream.listen((event) {
      setState(() {
        anim = true;
      });
      setState(() {
        number = number - event;
      });

      if (event == 1) {
        setState(() {
          text = 'Good Luck';
        });
      }
      if (event == 2) {
        setState(() {
          text = 'Begin';
        });
      }
    }, onDone: () {
      Future.delayed(Duration(milliseconds: 600), () {
        Navigator.push(
            context,
            PageTransition(
                duration: Duration(milliseconds: 0),
                type: PageTransitionType.rightToLeft,
                child: ChangeNotifierProvider(
                  create: (_) => BlockExcercise2(),
                  child: Excercise2WithAmin(
                    id: widget.id,
                    carasollist: widget.carasolList,
                    animation: widget.animation ?? '',
                    audio: widget.audio,
                    nameOfTast: widget.taskName,
                    min: widget.min,
                  ),
                )));
      });
    });
    FireBaseAnalyticsServices.setCurrentScreen(
        screenName: 'Remember to Stay Present',
        screenClass: 'Remember to Stay Present class');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorsThemes.darkThemeColor,
        body: Stack(
          children: [
            Container(
              height: height,
              width: width,
              child: Image.asset(
                'assets/digetshome.png',
                fit: BoxFit.fill,
              ),
            ),
            Container(
              width: width,
              child: Column(
                  children: [
                    AnimatedOpacity(
                      onEnd: () {
                        setState(() {
                          anim = false;
                        });
                      },
                      duration: Duration(seconds: 1),
                      opacity: anim == false ? 0 : 1,
                      child: AnimatedContainer(
                        height: anim == false ? 0 : height / 4,
                        width: anim == false ? 0 : width / 3,
                        duration: Duration(seconds: 1),
                        child: Image.asset(
                          number < 1 ? 'assets/1.png' : 'assets/$number.png',
                        ),
                      ),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: height / 2.8),
                child: Text(
                  '$text',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(width / 20),
                child: InkWell(
                  child: Icon(
                    Platform.isAndroid
                        ? Icons.arrow_back
                        : Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
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
}

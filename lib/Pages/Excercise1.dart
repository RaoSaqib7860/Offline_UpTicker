import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:upticker/ApiConfig/APiUtil.dart';
import 'package:upticker/ColorsThems/ThemesColors.dart';
import 'package:upticker/Pages/FinalHomePage.dart';
import 'package:upticker/Provider/BlockExcercise1.dart';
import 'package:upticker/Provider/BlockFinalHomePage.dart';

class Excercize1Page extends StatefulWidget {
  Excercize1Page({Key key, this.id}) : super(key: key);
  final String id;
  @override
  _Excercize1PageState createState() => _Excercize1PageState();
}

class _Excercize1PageState extends State<Excercize1Page>
    with TickerProviderStateMixin {
  AnimationController controller;
  bool animate = false;
  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  int seconde = 120;
  @override
  void initState() {
    print('${widget.id}');
    super.initState();
    final BlockExcercise1 _provider =
        Provider.of<BlockExcercise1>(context, listen: false);
    _provider.setId(widget.id);
    controller = AnimationController(
      vsync: this,
      duration: Duration(minutes: 1),
    )
      ..addListener(() {
        Duration duration = controller.duration * controller.value;

        if (seconde > duration.inSeconds) {
          seconde--;
          setState(() {
            initialValue = initialValue + 1.5;
          });
          seconde = duration.inSeconds;
        }
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          ApiUtils.updateFocusExcersice1Data(
              context: context, provider: _provider);
        }
      });
  }

  double initialValue = 0;

  Future onbackpress() async {
    controller.dispose();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (c) => ChangeNotifierProvider(
              create: (_) => BlockFinalHomePage(),
              child: FinalHomePageClass(),
            )));
  }

  @override
  Widget build(BuildContext context) {
    final BlockExcercise1 _provider = Provider.of<BlockExcercise1>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
        onWillPop: () => onbackpress(),
        child: Scaffold(
          key: _provider.scaffoldKey,
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     Navigator.push(
          //         context,
          //         PageTransition(
          //             duration: Duration(milliseconds: 500),
          //             type: PageTransitionType.rightToLeft,
          //             child: Excercise2WithAmin()));
          //   },
          //   child: Text('Next'),
          // ),

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
                          child: Container(
                            padding: EdgeInsets.only(top: height / 30),
                            child: Text(
                              'Push Ups',
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
                            controller.dispose();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (c) => ChangeNotifierProvider(
                                      create: (_) => BlockFinalHomePage(),
                                      child: FinalHomePageClass(),
                                    )));
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
            padding: EdgeInsets.only(left: width / 10, right: width / 10),
            child: Column(
                children: [
                  SizedBox(
                    height: height / 30,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        initialValue = 100;
                      });
                    },
                    child: Container(
                      height: height / 14,
                      width: width,
                      child: Center(
                          child: Text(
                        'Begin',
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
                  InkWell(
                    onTap: () {
                      setState(() {
                        initialValue = 0;
                      });
                    },
                    child: Container(
                      height: height / 14,
                      width: width,
                      child: Center(
                          child: Text(
                        'Reset',
                        style: TextStyle(color: ColorsThemes.darkThemeColor),
                      )),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              width: 1, color: ColorsThemes.mailColors),
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  SizedBox(
                    height: height / 20,
                  ),
                  Text(
                    '$timerString',
                    style: TextStyle(
                        fontSize: 80, color: Colors.black.withOpacity(0.7)),
                  ),
                  SizedBox(
                    height: height / 80,
                  ),
                  Container(
                    child: SleekCircularSlider(
                        initialValue: initialValue,
                        onChangeStart: (double startValue) {},
                        onChangeEnd: (double endValue) {
                          print('end value =$endValue');
                          print('cont value =${controller.value}');
                        },
                        innerWidget: (double value) {
                          return InkWell(
                            onTap: () {
                              if (controller.isAnimating) {
                                controller.stop();
                                setState(() {
                                  animate = false;
                                });
                              } else {
                                setState(() {
                                  animate = true;
                                });
                                controller.reverse(
                                    from: controller.value == 0.0
                                        ? 1.0
                                        : controller.value);
                              }
                            },
                            child: Container(
                              child: Center(
                                  child: Container(
                                child: Center(
                                    child: Icon(
                                  animate == false
                                      ? Icons.play_arrow
                                      : Icons.pause,
                                  color: Colors.white,
                                  size: 50,
                                )),
                                height: height / 8,
                                width: width / 4,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorsThemes.mailColors),
                              )),
                              decoration: BoxDecoration(),
                            ),
                          );
                        },
                        appearance: CircularSliderAppearance(
                            angleRange: 250,
                            animationEnabled: true,
                            customColors: CustomSliderColors(
                                hideShadow: false,
                                progressBarColor: ColorsThemes.mailColors,
                                trackColor: ColorsThemes.mailColors,
                                shadowColor: ColorsThemes.mailColors)),
                        onChange: (double value) {}),
                  ),
                  SizedBox(
                    height: height / 20,
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: width / 10, right: width / 10),
                    child: Row(
                      children: [
                        Container(
                          height: height / 12,
                          width: width / 6,
                          child: Image.asset(
                            'assets/alaram.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          height: height / 12,
                          width: width / 6,
                          child: Image.asset('assets/camernon.png'),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: height / 12,
                            width: width / 6,
                            child: Image.asset('assets/notenon.png'),
                          ),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center),
          ),
        ));
  }
}

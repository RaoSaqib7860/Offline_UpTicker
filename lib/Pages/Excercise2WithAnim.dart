import 'dart:async';
import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:upticker/ApiConfig/APiUtil.dart';
import 'package:upticker/ColorsThems/ThemesColors.dart';
import 'package:upticker/Pages/FinalHomePage.dart';
import 'package:upticker/Provider/BlockExcercise2.dart';
import 'package:upticker/Provider/BlockFinalHomePage.dart';
import 'package:upticker/ServicesForApp/FireBaseAnalytics.dart';
import 'package:vibration/vibration.dart';

class Excercise2WithAmin extends StatefulWidget {
  static var provider;

  Excercise2WithAmin(
      {Key key,
      this.id,
      this.audio,
      this.animation,
      this.nameOfTast,
      this.min,
      this.carasollist})
      : super(key: key);
  final String id;
  final String audio;
  final String animation;
  final nameOfTast;
  final min;
  final List carasollist;

  @override
  _Excercise2WithAminState createState() => _Excercise2WithAminState();
}

class _Excercise2WithAminState extends State<Excercise2WithAmin>
    with SingleTickerProviderStateMixin {
  Duration duration;
  bool timerpause = false;
  Timer _timer;
  double initialValue = 0.0;
  bool issecondtimer = false;
  double initialTime2;
  Timer _timer2;
  int min;
  int sec;
  bool isresume = false;
  bool ischeckresume = false;
  int totalsecond;
  Duration duration2;

  void startTimer2(BlockExcercise2 provider, BuildContext context) {
    _timer2 = Timer.periodic(Duration(seconds: 1), (timer) {
      print('in second is = ${duration2.inSeconds}');
      print('${widget.min}');
      if (initialValue < 100) {
        setState(() {
          duration2 = duration2 + Duration(seconds: 1);
          var value = initialValue + percentaget;
          if (value <= 100) {
            initialValue = value;
          } else {
            initialValue = 100;
          }
          print('ini value = $initialValue');
        });
        if (issecondtimer == false) {
          setState(() {
            issecondtimer = true;
          });
        }
        Duration second = Duration(minutes: widget.min);
        if (duration2.inSeconds > second.inSeconds - 60 &&
            ischeckresume == false &&
            widget.min >= 1) {
          setState(() {
            ischeckresume = true;
          });
          Vibration.vibrate(duration: 1000);
          showDialog(
              context: context,
              builder: (context) {
                var height = MediaQuery.of(context).size.height;
                var width = MediaQuery.of(context).size.width;
                return StatefulBuilder(
                  builder: (context, setState) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(20.0)), //this right here
                      child: FadeIn(
                        duration: Duration(seconds: 1),
                        child: Container(
                          height: height / 3.8,
                          width: width,
                          child: Column(
                            children: [
                              Text(
                                'You want to resume this task ?',
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(
                                height: height / 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                      setState(() {
                                        isresume = true;
                                        issecondtimer = true;
                                      });
                                    },
                                    child: Container(
                                      height: height / 30,
                                      width: width / 5,
                                      decoration: BoxDecoration(
                                          color: ColorsThemes.mailColors,
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      child: Center(
                                        child: Text(
                                          'Ok',
                                          style: TextStyle(
                                              color: Colors.white,
                                              letterSpacing: 0.5,
                                              fontSize: 10),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width / 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      height: height / 30,
                                      width: width / 5,
                                      decoration: BoxDecoration(
                                          color: ColorsThemes.mailColors,
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      child: Center(
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(
                                              color: Colors.white,
                                              letterSpacing: 0.5,
                                              fontSize: 10),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0)),
                          padding: EdgeInsets.all(width / 20),
                        ),
                      ),
                    );
                  },
                );
              });
        }
      } else {
        if (isresume == true) {
          if (_timer.isActive) {
            _timer.cancel();
          }
          if (issecondtimer == true) {
            _timer2.cancel();
          }
          setState(() {
            isresume = false;
            ischeckresume = false;
          });
          initialValue = 0.0;
          percentaget = (widget.min / (widget.min * 60)) * (100 / widget.min);
          duration2 = Duration(seconds: 0);
          totalsecond = duration2.inSeconds;
          Future.delayed(Duration(milliseconds: 300), () {
            startTimer2(provider, context);
          });
        } else {
          _timer2.cancel();
          ApiUtils.updateFocusExcersice2Data(
              context: context, provider: provider);
        }
      }
    });
  }

  GifController gifcontroller1;

  void startTimer(BlockExcercise2 provider, BuildContext context) {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (initialValue < 100) {
        setState(() {
          duration = duration + Duration(seconds: 1);
          var value = initialValue + percentaget;
          if (value <= 100) {
            initialValue = value;
          } else {
            initialValue = 100;
          }
        });
        Duration second = Duration(minutes: widget.min);
        if (duration.inSeconds > second.inSeconds - 60 &&
            ischeckresume == false &&
            widget.min >= 1) {
          Vibration.vibrate(duration: 1000);
          showDialog(
              context: context,
              builder: (context) {
                var height = MediaQuery.of(context).size.height;
                var width = MediaQuery.of(context).size.width;
                return StatefulBuilder(
                  builder: (context, setState) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(20.0)), //this right here
                      child: FadeIn(
                        duration: Duration(seconds: 1),
                        child: Container(
                          height: height / 3.8,
                          width: width,
                          child: Column(
                            children: [
                              Text(
                                'You want to resume this task ?',
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(
                                height: height / 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                      setState(() {
                                        isresume = true;
                                      });
                                    },
                                    child: Container(
                                      height: height / 30,
                                      width: width / 5,
                                      decoration: BoxDecoration(
                                          color: ColorsThemes.mailColors,
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      child: Center(
                                        child: Text(
                                          'Ok',
                                          style: TextStyle(
                                              color: Colors.white,
                                              letterSpacing: 0.5,
                                              fontSize: 10),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width / 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      height: height / 30,
                                      width: width / 5,
                                      decoration: BoxDecoration(
                                          color: ColorsThemes.mailColors,
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      child: Center(
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(
                                              color: Colors.white,
                                              letterSpacing: 0.5,
                                              fontSize: 10),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0)),
                          padding: EdgeInsets.all(width / 20),
                        ),
                      ),
                    );
                  },
                );
              });
        }
      } else {
        if (isresume == true) {
          setState(() {
            isresume = false;
            ischeckresume = false;
          });
          _timer.cancel();
          initialValue = 0.0;
          percentaget = (widget.min / (widget.min * 60)) * (100 / widget.min);
          duration = Duration(minutes: widget.min);
          totalsecond = duration.inSeconds;
          Future.delayed(Duration(milliseconds: 100), () {
            startTimer(provider, context);
          });
        } else {
          _timer.cancel();
          ApiUtils.updateFocusExcersice2Data(
              context: context, provider: provider);
        }
      }
    });
  }

  var percentaget;

  @override
  void initState() {
    print('carasol list is = ${widget.carasollist}');
    print('${widget.min}');
    percentaget = (widget.min / (widget.min * 60)) * (100 / widget.min);
    duration = Duration(seconds: 0);
    totalsecond = duration.inSeconds;
    final BlockExcercise2 _provider =
        Provider.of<BlockExcercise2>(context, listen: false);
    Future.delayed(Duration(milliseconds: 500), () {
      startTimer(_provider, context);
    });
    _provider.setId(widget.id);
    gifcontroller1 = GifController(
      vsync: this,
    );
    FireBaseAnalyticsServices.setCurrentScreen(
        screenName: 'Task screen', screenClass: 'Task screen class');
    var map = <String, dynamic>{
      'String': '${widget.nameOfTast}',
      'int': '${widget.id}'
    };
    FireBaseAnalyticsServices.addAnalyticsEvent(
        eventName: 'Task_detail', map: map);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    if (issecondtimer == true) {
      _timer2.cancel();
    }
    super.dispose();
  }

  Future onbackpress() async {
    if (_timer.isActive) {
      _timer.cancel();
    }
    if (issecondtimer == true) {
      _timer2.cancel();
    }
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (c) => ChangeNotifierProvider(
                  create: (_) => BlockFinalHomePage(),
                  child: FinalHomePageClass(),
                )),
        ModalRoute.withName('/'));
  }

  @override
  Widget build(BuildContext context) {
    final BlockExcercise2 _provider = Provider.of<BlockExcercise2>(context);
    Excercise2WithAmin.provider = _provider;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () => onbackpress(),
      child: SafeArea(
        child: Scaffold(
          key: _provider.scaffoldKey,
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(height / 6.3),
            child: AppBar(
              flexibleSpace: Container(
                decoration: BoxDecoration(color: Colors.white),
                margin: EdgeInsets.only(),
                height: height / 7.5,
                child: FadeInDown(
                  child: Container(
                    height: height / 7.5,
                    width: width,
                    child: Stack(
                      children: [
                        Container(
                          height: double.infinity,
                          width: double.infinity,
                          child: Container(
                            padding: EdgeInsets.only(top: height / 30),
                            child: Center(
                              child: Text(
                                '${widget.nameOfTast}',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
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
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (c) => ChangeNotifierProvider(
                                            create: (_) => BlockFinalHomePage(),
                                            child: FinalHomePageClass(),
                                          )),
                                  ModalRoute.withName('/'));
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: width / 30, top: height / 30),
                              height: height / 14,
                              width: width / 7,
                              child: Center(
                                child: Icon(
                                  Platform.isIOS
                                      ? Icons.arrow_back_ios
                                      : Icons.arrow_back,
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
              ),
              elevation: 0,
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
            ),
          ),
          body: Container(
            height: height,
            width: width,
            padding: EdgeInsets.only(
                left: width / 20, right: width / 20, top: width / 100),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    ApiUtils.updateFocusExcersice2Data(
                        context: context, provider: _provider);
                    if (_timer.isActive) {
                      _timer.cancel();
                    }
                    if (issecondtimer == true) {
                      _timer2.cancel();
                    }
                    setState(() {
                      initialValue = 100.0;
                    });
                  },
                  child: FadeInDownBig(
                    child: Container(
                      height: height / 14,
                      width: width,
                      margin:
                          EdgeInsets.only(left: width / 30, right: width / 30),
                      child: Center(
                          child: Text(
                        'Complete',
                        style: TextStyle(color: Colors.white),
                      )),
                      decoration: BoxDecoration(
                          color: ColorsThemes.mailColors,
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
                SizedBox(
                  height: height / 50,
                ),
                widget.carasollist == null
                    ? SizedBox()
                    : CarasolSliders(
                        list: widget.carasollist,
                      ),
                SizedBox(
                  height: height / 50,
                ),
                Container(
                  height: height / 3.2,
                  width: width,
                  decoration: BoxDecoration(color: Colors.white),
                  child: widget.animation == ''
                      ? SizedBox(
                          height: height / 2.7,
                          width: width,
                        )
                      : Image.network(
                          "${ApiUtils.apiURL}${widget.animation}",
                        ),
                  // child: GifImage(
                  //   controller: gifcontroller1,
                  //   image: NetworkImage(
                  //     "http://212.46.130.138:8000${widget.animation}",
                  //   ),
                  // ),
                ),
                SizedBox(
                  height: height / 50,
                ),
                Text(
                  issecondtimer == true
                      ? widget.min > 60
                          ? '${duration2.abs().toString().split('.')[0]}'
                          : '00:${(duration2.inMinutes).toString().padLeft(2, '0')}:${(duration2.inSeconds % 60).toString().padLeft(2, '0')}'
                      : widget.min > 60
                          ? '${duration.abs().toString().split('.')[0]}'
                          : '00:${(duration.inMinutes).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
                  style: TextStyle(
                      fontSize: 50,
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin:
                          EdgeInsets.only(top: width / 20, left: width / 20),
                      child: SleekCircularSlider(
                        initialValue: initialValue,
                        onChangeStart: (double startValue) {},
                        onChangeEnd: (double endValue) {
                          print('end value =$endValue');
                          initialValue = endValue;
                          if (_timer.isActive) {
                            _timer.cancel();
                          }
                          if (issecondtimer == true) {
                            _timer2.cancel();
                          }
                          double value = (endValue / 100) * widget.min;
                          String newValue = value.toString();
                          print('$newValue');
                          List l = newValue.split('.');
                          min = int.parse(l[0]);
                          double v = double.parse('.${l[1]}');
                          String g = (v * 60).toString();
                          List f = g.split('.');
                          sec = int.parse(f[0]);
                          print('min = $min and se = $sec');
                          duration2 = Duration(minutes: min, seconds: sec);
                          startTimer2(_provider, context);
                        },
                        onChange: (value) {
                          print('on changed $value');
                        },
                        innerWidget: (double value) {
                          return InkWell(
                            focusColor: Colors.white,
                            highlightColor: Colors.white,
                            hoverColor: Colors.white,
                            onTap: () {
                              if (timerpause == false) {
                                setState(() {
                                  timerpause = true;
                                });
                                if (_timer.isActive) {
                                  _timer.cancel();
                                }
                                if (issecondtimer == true) {
                                  _timer2.cancel();
                                }
                              } else {
                                double value =
                                    (initialValue / 100) * widget.min;
                                String newValue = value.toString();
                                print('$newValue');
                                List l = newValue.split('.');
                                min = int.parse(l[0]);
                                double v = double.parse('.${l[1]}');
                                String g = (v * 60).toString();
                                List f = g.split('.');
                                sec = int.parse(f[0]);
                                print('min = $min and se = $sec');
                                duration2 =
                                    Duration(minutes: min, seconds: sec);
                                startTimer2(_provider, context);
                                setState(() {
                                  timerpause = false;
                                });
                              }
                            },
                            child: Container(
                              child: Center(
                                  child: Container(
                                child: Center(
                                    child: Icon(
                                  timerpause == false
                                      ? Icons.pause
                                      : Icons.play_arrow,
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
                            spinnerDuration: 0,
                            animationEnabled: false,
                            customColors: CustomSliderColors(
                                hideShadow: false,
                                progressBarColor: ColorsThemes.mailColors,
                                trackColor: ColorsThemes.mailColors,
                                shadowColor: ColorsThemes.mailColors)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CarasolSliders extends StatefulWidget {
  CarasolSliders({Key key, this.list}) : super(key: key);
  final List list;

  @override
  _CarasolSlidersState createState() => _CarasolSlidersState();
}

class _CarasolSlidersState extends State<CarasolSliders> {
  int _curent;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        CarouselSlider(
            items: widget.list
                .map((item) => Container(
                      padding:
                          EdgeInsets.only(left: width / 30, right: width / 30),
                      width: width,
                      child: Center(
                          child: Text('$item',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.white))),
                      decoration: BoxDecoration(
                          color: ColorsThemes.mailColors,
                          borderRadius: BorderRadius.circular(5)),
                    ))
                .toList(),
            options: CarouselOptions(
              height: height / 30,
              aspectRatio: 16 / 9,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _curent = index;
                });
              },
              autoPlayInterval: Duration(seconds: 5),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            )),
      ],
    );
  }
}

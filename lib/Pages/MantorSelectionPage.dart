import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:upticker/ApiConfig/APiUtil.dart';
import 'package:upticker/ColorsThems/ThemesColors.dart';
import 'package:upticker/LocalWidget/LocalWidget.dart';
import 'package:upticker/Pages/FinalHomePage.dart';
import 'package:upticker/Pages/HomePage.dart';
import 'package:upticker/Pages/ProfileUpdate.dart';
import 'package:upticker/Provider/BlockFinalHomePage.dart';
import 'package:upticker/Provider/BlockHomeSubMentor.dart';
import 'package:upticker/Provider/BlockMantorSelection.dart';
import 'package:upticker/Provider/BlockUserGenderSelection.dart';
import 'package:upticker/ServicesForApp/FireBaseAnalytics.dart';

import 'Login.dart';

class MantorSelectionPage extends StatefulWidget {
  MantorSelectionPage({Key key, this.isafter, this.isAfter}) : super(key: key);
  final bool isafter;
  final List isAfter;

  @override
  _MantorSelectionPageState createState() => _MantorSelectionPageState();
}

class _MantorSelectionPageState extends State<MantorSelectionPage> {
  bool ismain = false;
  bool isskip = false;
  List listchek = [];

  @override
  void initState() {
    LoginPage.defaultlistAfter = widget.isAfter;
    final BlockMantorSelection _provider =
        Provider.of<BlockMantorSelection>(context, listen: false);
    loadTaskList(_provider);
    FireBaseAnalyticsServices.setCurrentScreen(
        screenName: 'Mentors', screenClass: 'Mentors class');
    super.initState();
  }

  loadTaskList(BlockMantorSelection provider) async {
    await ApiUtils.getuserGenderPageData(provider: provider)
        .then((value) async => {
              await ApiUtils.getMantorTaskData(
                      provider: provider, scaffoldkey: provider.scaffoldKey)
                  .then((value) async => {
                        await provider.seprationList(),
                        Future.delayed(Duration(seconds: 0), () {
                          provider.setLodingList(true);
                          print('${provider.finalDataList}');
                          print('${provider.finalboolList}');
                        })
                      })
            });
  }

  @override
  Widget build(BuildContext context) {
    final BlockMantorSelection _provider =
        Provider.of<BlockMantorSelection>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        key: _provider.scaffoldKey,
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
                height: height,
                width: width,
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: height / 20,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          '',
                          style: TextStyle(
                              color: ColorsThemes.lightBlackColor,
                              fontSize: 16),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          'Choose a Mentor',
                          style: TextStyle(
                            color: ColorsThemes.lightBlackColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: height / 50,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        height: height / 1.5,
                        padding: EdgeInsets.only(
                            left: width / 50, right: width / 100),
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
                                  List lastList = _provider.finalboolList
                                      .elementAt(
                                          _provider.finalboolList.length - 1);
                                  int index =
                                      _provider.finalboolList.length - 1;

                                  return index == i
                                      ? lastList.length == 1
                                          ? Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                InkWell(
                                                  splashColor: Colors.white,
                                                  highlightColor: Colors.white,
                                                  onTap: () {
                                                    // if (ismain == true) {
                                                    //   listchek.clear();
                                                    //   if (_provider
                                                    //               .finalboolList[
                                                    //           i][0] ==
                                                    //       false) {
                                                    //     setState(() {
                                                    //       _provider
                                                    //               .finalboolList[
                                                    //           i][0] = true;
                                                    //     });
                                                    //     _provider.addSelectedID(
                                                    //         '${_provider.finalDataList[i][0]['id']}');
                                                    //   } else {
                                                    //     setState(() {
                                                    //       _provider
                                                    //               .finalboolList[
                                                    //           i][0] = false;
                                                    //     });
                                                    //     _provider.removeSelectedID(
                                                    //         '${_provider.finalDataList[i][0]['id']}');
                                                    //   }
                                                    //   Future.delayed(
                                                    //       Duration(
                                                    //           milliseconds:
                                                    //               200), () {
                                                    //     for (List list
                                                    //         in _provider
                                                    //             .finalboolList) {
                                                    //       for (var i in list) {
                                                    //         listchek.add(i);
                                                    //       }
                                                    //     }
                                                    //     if (!listchek
                                                    //         .contains(true)) {
                                                    //       setState(() {
                                                    //         isskip = false;
                                                    //       });
                                                    //     } else {
                                                    //       setState(() {
                                                    //         isskip = true;
                                                    //       });
                                                    //     }
                                                    //   });
                                                    // } else {}
                                                    openDailog(
                                                        index: i,
                                                        subindex: 0,
                                                        provider: _provider,
                                                        orderid:
                                                            '${_provider.finalDataList[i][0]['id']}');
                                                  },
                                                  child: _provider.finalboolList[
                                                              i][0] ==
                                                          false
                                                      ? LocalWidgets
                                                          .withOutColorBox(
                                                              context,
                                                              '${_provider.finalDataList[i][0]['name']}')
                                                      : LocalWidgets.withColorBox(
                                                          context,
                                                          '${_provider.finalDataList[i][0]['name']}'),
                                                ),
                                              ],
                                            )
                                          : lastList.length == 2
                                              ? Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    InkWell(
                                                      splashColor: Colors.white,
                                                      highlightColor:
                                                          Colors.white,
                                                      onTap: () {
                                                        openDailog(
                                                            index: i,
                                                            subindex: 0,
                                                            provider: _provider,
                                                            orderid:
                                                                '${_provider.finalDataList[i][0]['id']}');
                                                      },
                                                      child: _provider.finalboolList[
                                                                  i][0] ==
                                                              false
                                                          ? LocalWidgets
                                                              .withOutColorBox(
                                                                  context,
                                                                  '${_provider.finalDataList[i][0]['name']}')
                                                          : LocalWidgets
                                                              .withColorBox(
                                                                  context,
                                                                  '${_provider.finalDataList[i][0]['name']}'),
                                                    ),
                                                    SizedBox(
                                                      height: 110,
                                                    ),
                                                    InkWell(
                                                      splashColor: Colors.white,
                                                      highlightColor:
                                                          Colors.white,
                                                      onTap: () {
                                                        openDailog(
                                                            index: i,
                                                            subindex: 1,
                                                            provider: _provider,
                                                            orderid:
                                                                '${_provider.finalDataList[i][1]['id']}');
                                                      },
                                                      child: _provider.finalboolList[
                                                                  i][1] ==
                                                              false
                                                          ? LocalWidgets
                                                              .withOutColorBox(
                                                                  context,
                                                                  '${_provider.finalDataList[i][1]['name']}')
                                                          : LocalWidgets
                                                              .withColorBox(
                                                                  context,
                                                                  '${_provider.finalDataList[i][1]['name']}'),
                                                    ),
                                                  ],
                                                )
                                              : lastList.length == 3
                                                  ? Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        InkWell(
                                                          splashColor:
                                                              Colors.white,
                                                          highlightColor:
                                                              Colors.white,
                                                          onTap: () {
                                                            openDailog(
                                                                index: i,
                                                                subindex: 0,
                                                                provider:
                                                                    _provider,
                                                                orderid:
                                                                    '${_provider.finalDataList[i][0]['id']}');
                                                          },
                                                          child: _provider.finalboolList[
                                                                      i][0] ==
                                                                  false
                                                              ? LocalWidgets
                                                                  .withOutColorBox(
                                                                      context,
                                                                      '${_provider.finalDataList[i][0]['name']}')
                                                              : LocalWidgets
                                                                  .withColorBox(
                                                                      context,
                                                                      '${_provider.finalDataList[i][0]['name']}'),
                                                        ),
                                                        InkWell(
                                                          splashColor:
                                                              Colors.white,
                                                          highlightColor:
                                                              Colors.white,
                                                          onTap: () {
                                                            openDailog(
                                                                index: i,
                                                                subindex: 1,
                                                                provider:
                                                                    _provider,
                                                                orderid:
                                                                    '${_provider.finalDataList[i][1]['id']}');
                                                          },
                                                          child: _provider.finalboolList[
                                                                      i][1] ==
                                                                  false
                                                              ? LocalWidgets
                                                                  .withOutColorBox(
                                                                      context,
                                                                      '${_provider.finalDataList[i][1]['name']}')
                                                              : LocalWidgets
                                                                  .withColorBox(
                                                                      context,
                                                                      '${_provider.finalDataList[i][1]['name']}'),
                                                        ),
                                                        InkWell(
                                                          splashColor:
                                                              Colors.white,
                                                          highlightColor:
                                                              Colors.white,
                                                          onTap: () {
                                                            openDailog(
                                                                index: i,
                                                                subindex: 2,
                                                                provider:
                                                                    _provider,
                                                                orderid:
                                                                    '${_provider.finalDataList[i][2]['id']}');
                                                          },
                                                          child: _provider.finalboolList[
                                                                      i][2] ==
                                                                  false
                                                              ? LocalWidgets
                                                                  .withOutColorBox(
                                                                      context,
                                                                      '${_provider.finalDataList[i][2]['name']}')
                                                              : LocalWidgets
                                                                  .withColorBox(
                                                                      context,
                                                                      '${_provider.finalDataList[i][2]['name']}'),
                                                        ),
                                                        SizedBox(
                                                          height: 100,
                                                        )
                                                      ],
                                                    )
                                                  : Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        InkWell(
                                                          splashColor:
                                                              Colors.white,
                                                          highlightColor:
                                                              Colors.white,
                                                          onTap: () {
                                                            openDailog(
                                                                index: i,
                                                                subindex: 0,
                                                                provider:
                                                                    _provider,
                                                                orderid:
                                                                    '${_provider.finalDataList[i][0]['id']}');
                                                          },
                                                          child: _provider.finalboolList[
                                                                      i][0] ==
                                                                  false
                                                              ? LocalWidgets
                                                                  .withOutColorBox(
                                                                      context,
                                                                      '${_provider.finalDataList[i][0]['name']}')
                                                              : LocalWidgets
                                                                  .withColorBox(
                                                                      context,
                                                                      '${_provider.finalDataList[i][0]['name']}'),
                                                        ),
                                                        InkWell(
                                                          splashColor:
                                                              Colors.white,
                                                          highlightColor:
                                                              Colors.white,
                                                          onTap: () {
                                                            openDailog(
                                                                index: i,
                                                                subindex: 1,
                                                                provider:
                                                                    _provider,
                                                                orderid:
                                                                    '${_provider.finalDataList[i][1]['id']}');
                                                          },
                                                          child: _provider.finalboolList[
                                                                      i][1] ==
                                                                  false
                                                              ? LocalWidgets
                                                                  .withOutColorBox(
                                                                      context,
                                                                      '${_provider.finalDataList[i][1]['name']}')
                                                              : LocalWidgets
                                                                  .withColorBox(
                                                                      context,
                                                                      '${_provider.finalDataList[i][1]['name']}'),
                                                        ),
                                                        InkWell(
                                                          splashColor:
                                                              Colors.white,
                                                          highlightColor:
                                                              Colors.white,
                                                          onTap: () {
                                                            openDailog(
                                                                index: i,
                                                                subindex: 2,
                                                                provider:
                                                                    _provider,
                                                                orderid:
                                                                    '${_provider.finalDataList[i][2]['id']}');
                                                          },
                                                          child: _provider.finalboolList[
                                                                      i][2] ==
                                                                  false
                                                              ? LocalWidgets
                                                                  .withOutColorBox(
                                                                      context,
                                                                      '${_provider.finalDataList[i][2]['name']}')
                                                              : LocalWidgets
                                                                  .withColorBox(
                                                                      context,
                                                                      '${_provider.finalDataList[i][2]['name']}'),
                                                        ),
                                                        InkWell(
                                                          splashColor:
                                                              Colors.white,
                                                          highlightColor:
                                                              Colors.white,
                                                          onTap: () {
                                                            openDailog(
                                                                index: i,
                                                                subindex: 3,
                                                                provider:
                                                                    _provider,
                                                                orderid:
                                                                    '${_provider.finalDataList[i][3]['id']}');
                                                          },
                                                          child: _provider.finalboolList[
                                                                      i][3] ==
                                                                  false
                                                              ? LocalWidgets
                                                                  .withOutColorBox(
                                                                      context,
                                                                      '${_provider.finalDataList[i][3]['name']}')
                                                              : LocalWidgets
                                                                  .withColorBox(
                                                                      context,
                                                                      '${_provider.finalDataList[i][3]['name']}'),
                                                        ),
                                                      ],
                                                    )
                                      : i.isOdd
                                          ? Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                InkWell(
                                                  splashColor: Colors.white,
                                                  highlightColor: Colors.white,
                                                  onTap: () {
                                                    openDailog(
                                                        index: i,
                                                        subindex: 0,
                                                        provider: _provider,
                                                        orderid:
                                                            '${_provider.finalDataList[i][0]['id']}');
                                                  },
                                                  child: _provider.finalboolList[
                                                              i][0] ==
                                                          false
                                                      ? LocalWidgets
                                                          .withOutColorBox(
                                                              context,
                                                              '${_provider.finalDataList[i][0]['name']}')
                                                      : LocalWidgets.withColorBox(
                                                          context,
                                                          '${_provider.finalDataList[i][0]['name']}'),
                                                ),
                                                InkWell(
                                                  splashColor: Colors.white,
                                                  highlightColor: Colors.white,
                                                  onTap: () {
                                                    openDailog(
                                                        index: i,
                                                        subindex: 1,
                                                        provider: _provider,
                                                        orderid:
                                                            '${_provider.finalDataList[i][1]['id']}');
                                                  },
                                                  child: _provider.finalboolList[
                                                              i][1] ==
                                                          false
                                                      ? LocalWidgets
                                                          .withOutColorBox(
                                                              context,
                                                              '${_provider.finalDataList[i][1]['name']}')
                                                      : LocalWidgets.withColorBox(
                                                          context,
                                                          '${_provider.finalDataList[i][1]['name']}'),
                                                ),
                                                InkWell(
                                                  splashColor: Colors.white,
                                                  highlightColor: Colors.white,
                                                  onTap: () {
                                                    openDailog(
                                                        index: i,
                                                        subindex: 2,
                                                        provider: _provider,
                                                        orderid:
                                                            '${_provider.finalDataList[i][2]['id']}');
                                                  },
                                                  child: _provider.finalboolList[
                                                              i][2] ==
                                                          false
                                                      ? LocalWidgets
                                                          .withOutColorBox(
                                                              context,
                                                              '${_provider.finalDataList[i][2]['name']}')
                                                      : LocalWidgets.withColorBox(
                                                          context,
                                                          '${_provider.finalDataList[i][2]['name']}'),
                                                ),
                                                InkWell(
                                                  splashColor: Colors.white,
                                                  highlightColor: Colors.white,
                                                  onTap: () {
                                                    openDailog(
                                                        index: i,
                                                        subindex: 3,
                                                        provider: _provider,
                                                        orderid:
                                                            '${_provider.finalDataList[i][3]['id']}');
                                                  },
                                                  child: _provider.finalboolList[
                                                              i][3] ==
                                                          false
                                                      ? LocalWidgets
                                                          .withOutColorBox(
                                                              context,
                                                              '${_provider.finalDataList[i][3]['name']}')
                                                      : LocalWidgets.withColorBox(
                                                          context,
                                                          '${_provider.finalDataList[i][3]['name']}'),
                                                ),
                                              ],
                                            )
                                          : Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                InkWell(
                                                  splashColor: Colors.white,
                                                  highlightColor: Colors.white,
                                                  onTap: () {
                                                    openDailog(
                                                        index: i,
                                                        subindex: 0,
                                                        provider: _provider,
                                                        orderid:
                                                            '${_provider.finalDataList[i][0]['id']}');
                                                  },
                                                  child: _provider.finalboolList[
                                                              i][0] ==
                                                          false
                                                      ? LocalWidgets
                                                          .withOutColorBox(
                                                              context,
                                                              '${_provider.finalDataList[i][0]['name']}')
                                                      : LocalWidgets.withColorBox(
                                                          context,
                                                          '${_provider.finalDataList[i][0]['name']}'),
                                                ),
                                                InkWell(
                                                  splashColor: Colors.white,
                                                  highlightColor: Colors.white,
                                                  onTap: () {
                                                    openDailog(
                                                        index: i,
                                                        subindex: 1,
                                                        provider: _provider,
                                                        orderid:
                                                            '${_provider.finalDataList[i][1]['id']}');
                                                  },
                                                  child: _provider.finalboolList[
                                                              i][1] ==
                                                          false
                                                      ? LocalWidgets
                                                          .withOutColorBox(
                                                              context,
                                                              '${_provider.finalDataList[i][1]['name']}')
                                                      : LocalWidgets.withColorBox(
                                                          context,
                                                          '${_provider.finalDataList[i][1]['name']}'),
                                                ),
                                                InkWell(
                                                  splashColor: Colors.white,
                                                  highlightColor: Colors.white,
                                                  onTap: () {
                                                    openDailog(
                                                        index: i,
                                                        subindex: 2,
                                                        provider: _provider,
                                                        orderid:
                                                            '${_provider.finalDataList[i][2]['id']}');
                                                  },
                                                  child: _provider.finalboolList[
                                                              i][2] ==
                                                          false
                                                      ? LocalWidgets
                                                          .withOutColorBox(
                                                              context,
                                                              '${_provider.finalDataList[i][2]['name']}')
                                                      : LocalWidgets.withColorBox(
                                                          context,
                                                          '${_provider.finalDataList[i][2]['name']}'),
                                                ),
                                              ],
                                            );
                                },
                                itemCount: _provider.finalDataList.length,
                                scrollDirection: Axis.horizontal,
                              ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            splashColor: Colors.white,
                            highlightColor: Colors.white,
                            onTap: () {
                              if (_provider.listSelectedId.length >= 1) {
                                if (_provider.apicall == false) {
                                  _provider.setAPiCall(true);
                                  ApiUtils.sendSlectedMentorData(
                                      provider: _provider,
                                      isafter: widget.isafter,
                                      scaffoldkey: _provider.scaffoldKey);
                                }
                              } else {
                                if (_provider.userProfile == true) {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          duration: Duration(milliseconds: 500),
                                          type: PageTransitionType.rightToLeft,
                                          child: ChangeNotifierProvider(
                                            create: (_) => BlockFinalHomePage(),
                                            child: FinalHomePageClass(),
                                          )));
                                } else {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          duration: Duration(milliseconds: 500),
                                          type: PageTransitionType.rightToLeft,
                                          child: ChangeNotifierProvider(
                                            create: (_) =>
                                                BlockUserGenderSelection(),
                                            child: ProfileUpdate(),
                                          )));
                                }
                              }
                            },
                            child: Container(
                              height: height / 14,
                              width: width / 5,
                              child: Center(
                                child: Text(
                                  _provider.isskip ? 'Next' : 'Skip',
                                  style: TextStyle(
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: ColorsThemes.mailColors,
                                  borderRadius: BorderRadius.circular(8)),
                              margin: EdgeInsets.only(
                                  top: width / 20,
                                  left: width / 20,
                                  right: width / 20),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(width / 20),
                child: InkWell(
                  child: Icon(Platform.isAndroid
                      ? Icons.arrow_back
                      : Icons.arrow_back_ios),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  openDailog(
      {BlockMantorSelection provider,
      String orderid,
      int index,
      int subindex}) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return ChangeNotifierProvider(
              create: (_) => BlockHomeSubmentor(),
              child: FunkyOverlay(
                provider: provider,
                id: orderid,
                index: index,
                subIndex: subindex,
              ),
            );
          },
        );
      },
    );
  }
}

class FunkyOverlay extends StatefulWidget {
  const FunkyOverlay({
    Key key,
    this.provider,
    this.id,
    this.index,
    this.subIndex,
  }) : super(key: key);
  final BlockMantorSelection provider;
  final String id;
  final int index;
  final int subIndex;

  @override
  State<StatefulWidget> createState() => FunkyOverlayState();
}

class FunkyOverlayState extends State<FunkyOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;
  bool anim = false;
  List bools = [false, false, false, false, false, false];

  @override
  void initState() {
    final _provider = Provider.of<BlockHomeSubmentor>(context, listen: false);
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
    Future.delayed(Duration(milliseconds: 450), () {
      setState(() {
        anim = true;
      });
    });
    apiCalling(_provider);
  }

  apiCalling(BlockHomeSubmentor provider) {
    ApiUtils.subMentorTask(
        provider: provider, id: widget.id, parentProvider: widget.provider);
  }

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<BlockHomeSubmentor>(
      context,
    );
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: AnimatedOpacity(
            opacity: anim == false ? 0 : 1,
            duration: Duration(seconds: 1),
            curve: Curves.ease,
            child: AnimatedContainer(
              duration: Duration(seconds: 1),
              curve: Curves.ease,
              margin: EdgeInsets.only(top: anim == false ? height / 30 : 0),
              height: height / 1.5,
              width: width / 1.2,
              decoration: ShapeDecoration(
                  color: Colors.black.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: !_provider.loading
                  ? Center(
                      child: CupertinoActivityIndicator(
                        animating: true,
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: height / 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Choose a Mentor Task',
                              style: TextStyle(
                                letterSpacing: 0.5,
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              width: width / 30,
                            ),
                            InkWell(
                              onTap: () {
                                for (var i = 0;
                                    i < _provider.boolList.length;
                                    i++) {
                                  setState(() {
                                    _provider.boolList[i] = true;
                                  });
                                  widget.provider.addSelectedID(
                                      '${_provider.listOfTask[i]['id']}');
                                }
                              },
                              child: Container(
                                  width: width / 5,
                                  height: height / 35,
                                  child: Center(
                                    child: Text(
                                      'Select All',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 5,
                                            spreadRadius: 2,
                                            offset: Offset(2, 5))
                                      ],
                                      color: ColorsThemes.mailColors,
                                      borderRadius: BorderRadius.circular(20))),
                            )
                          ],
                        ),
                        SizedBox(
                          height: height / 30,
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemBuilder: (c, i) {
                                return InkWell(
                                  onTap: () {
                                    if (_provider.boolList[i] == false) {
                                      setState(() {
                                        _provider.boolList[i] = true;
                                      });
                                      if (!widget.provider.listSelectedId.contains(
                                          '${_provider.listOfTask[i]['id']}')) {
                                        widget.provider.addSelectedID(
                                            '${_provider.listOfTask[i]['id']}');
                                      }
                                    } else {
                                      setState(() {
                                        _provider.boolList[i] = false;
                                      });
                                      int index = widget.provider.listSelectedId
                                          .indexOf(
                                              '${_provider.listOfTask[i]['id']}');
                                      widget.provider.listSelectedId
                                          .removeAt(index);
                                    }
                                  },
                                  child: _provider.boolList[i] == false
                                      ? Container(
                                          width: width / 3,
                                          height: height / 20,
                                          child: Center(
                                            child: Text(
                                              '${_provider.listOfTask[i]['name']}',
                                              style: TextStyle(
                                                  color: ColorsThemes
                                                      .lightBlackColor,
                                                  fontSize: 12,
                                                  letterSpacing: 0.3),
                                            ),
                                          ),
                                          margin: EdgeInsets.only(
                                              bottom: height / 30,
                                              left: width / 20,
                                              right: width / 20),
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black26,
                                                    blurRadius: 5,
                                                    spreadRadius: 2,
                                                    offset: Offset(2, 5))
                                              ],
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20)))
                                      : SubTaskAinm(
                                          text:
                                              '${_provider.listOfTask[i]['name']}',
                                        ),
                                );
                              },
                              itemCount: _provider.listOfTask.length),
                        ),
                        SizedBox(
                          height: height / 50,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            if (widget.provider.listSelectedId.length > 0) {
                              widget.provider.setisSKip(true);
                            } else {
                              widget.provider.setisSKip(false);
                            }
                            if (_provider.boolList.contains(true)) {
                              setState(() {
                                widget.provider.finalboolList[widget.index]
                                    [widget.subIndex] = true;
                              });
                            } else {
                              setState(() {
                                widget.provider.finalboolList[widget.index]
                                    [widget.subIndex] = false;
                              });
                            }
                          },
                          child: Container(
                              width: width / 3,
                              height: height / 20,
                              child: Center(
                                child: Text(
                                  'Next',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              margin: EdgeInsets.only(
                                  bottom: height / 30,
                                  left: width / 30,
                                  right: width / 30),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 5,
                                        spreadRadius: 2,
                                        offset: Offset(2, 5))
                                  ],
                                  color: ColorsThemes.mailColors,
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class SubTaskAinm extends StatefulWidget {
  SubTaskAinm({Key key, this.text}) : super(key: key);
  final text;

  @override
  _SubTaskAinmState createState() => _SubTaskAinmState();
}

class _SubTaskAinmState extends State<SubTaskAinm> {
  bool anim = false;

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 150), () {
      setState(() {
        anim = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return AnimatedContainer(
        duration: Duration(seconds: 1, milliseconds: 100),
        curve: Curves.ease,
        width: width / 1.2,
        height: height / 20,
        child: Center(
          child: AnimatedDefaultTextStyle(
            duration: Duration(minutes: 1),
            style: TextStyle(
              letterSpacing: 0.3,
              color: Colors.white,
              fontSize: 10,
            ),
            child: AutoSizeText(
              '${widget.text}',
              style: TextStyle(
                  color: Colors.white, fontSize: 10, letterSpacing: 0.3),
              maxLines: 1,
            ),
          ),
        ),
        margin: EdgeInsets.only(
            bottom: height / 30,
            left: anim == false ? width / 3 : width / 20,
            right: anim == false ? width / 3 : width / 20),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              spreadRadius: 2,
              offset: Offset(2, 5))
        ], color: Colors.blue, borderRadius: BorderRadius.circular(20)));
  }
}

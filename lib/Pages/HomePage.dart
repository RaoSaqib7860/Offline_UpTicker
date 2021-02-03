import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:upticker/ApiConfig/APiUtil.dart';
import 'package:upticker/ColorsThems/ThemesColors.dart';
import 'package:upticker/LocalWidget/LocalWidget.dart';
import 'package:upticker/Provider/BlockHomePage.dart';
import 'package:upticker/ServicesForApp/FireBaseAnalytics.dart';
import 'package:upticker/SharedPreference/SharedPreference.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController;
  List listAfter = [];

  @override
  void initState() {
    _scrollController = ScrollController();
    final BlockHomePage _provider =
        Provider.of<BlockHomePage>(context, listen: false);
    loadTaskList(_provider);
    sethint(_provider);
    FireBaseAnalyticsServices.setCurrentScreen(
        screenName: 'Bucket',
        screenClass: 'Bucket class');
    super.initState();
  }

  loadTaskList(BlockHomePage provider) async {
    await ApiUtils.getTaskData(
            provider: provider, scaffoldkey: provider.scaffoldKey)
        .then((value) async => {
              await provider.seprationList(),
              provider.setLodingList(true),
            })
        .then((value) => {sethint(provider)});
  }

  sethint(BlockHomePage provider) async {
    Future<String> inapp = SharedPreferenceClass.getInApp();
    inapp.then((value) => {
          if (value == null)
            {
              Future.delayed(Duration(milliseconds: 500), () {
                provider.setisanim(true);
              }),
              Future.delayed(Duration(seconds: 3), () {
                provider.setisanim(false);
              }),
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    final BlockHomePage _provider = Provider.of<BlockHomePage>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        key: _provider.scaffoldKey,
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            AnimatedContainer(
                height: height,
                width: width,
                duration: Duration(seconds: 2),
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
                          'What would you like to do',
                          style: TextStyle(
                            color: ColorsThemes.lightBlackColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: height / 100,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          'more?',
                          style: TextStyle(
                              color: ColorsThemes.lightBlackColor,
                              fontSize: 16),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: height / 30,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: AnimatedContainer(
                        height: height / 1.5,
                        padding: EdgeInsets.only(
                            left: width / 50, right: width / 100),
                        duration: Duration(milliseconds: 500),
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
                                controller: _scrollController,
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
                                                    if (_provider.finalboolList[
                                                            i][0] ==
                                                        false) {
                                                      setState(() {
                                                        _provider.finalboolList[
                                                            i][0] = true;
                                                      });
                                                      _provider.addSelectedID(
                                                          '${_provider.finalDataList[i][0]['id']}');
                                                    } else {
                                                      setState(() {
                                                        _provider.finalboolList[
                                                            i][0] = false;
                                                      });
                                                      _provider.removeSelectedID(
                                                          '${_provider.finalDataList[i][0]['id']}');
                                                    }
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
                                                        if (_provider
                                                                    .finalboolList[
                                                                i][0] ==
                                                            false) {
                                                          setState(() {
                                                            _provider
                                                                    .finalboolList[
                                                                i][0] = true;
                                                          });
                                                          _provider.addSelectedID(
                                                              '${_provider.finalDataList[i][0]['id']}');
                                                        } else {
                                                          setState(() {
                                                            _provider
                                                                    .finalboolList[
                                                                i][0] = false;
                                                          });
                                                          _provider
                                                              .removeSelectedID(
                                                                  '${_provider.finalDataList[i][0]['id']}');
                                                        }
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
                                                        if (_provider
                                                                    .finalboolList[
                                                                i][1] ==
                                                            false) {
                                                          setState(() {
                                                            _provider
                                                                    .finalboolList[
                                                                i][1] = true;
                                                          });
                                                          _provider.addSelectedID(
                                                              '${_provider.finalDataList[i][1]['id']}');
                                                        } else {
                                                          setState(() {
                                                            _provider
                                                                    .finalboolList[
                                                                i][1] = false;
                                                          });
                                                          _provider
                                                              .removeSelectedID(
                                                                  '${_provider.finalDataList[i][1]['id']}');
                                                        }
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
                                                            if (_provider
                                                                        .finalboolList[
                                                                    i][0] ==
                                                                false) {
                                                              setState(() {
                                                                _provider.finalboolList[
                                                                        i][0] =
                                                                    true;
                                                              });
                                                              _provider
                                                                  .addSelectedID(
                                                                      '${_provider.finalDataList[i][0]['id']}');
                                                            } else {
                                                              setState(() {
                                                                _provider.finalboolList[
                                                                        i][0] =
                                                                    false;
                                                              });
                                                              _provider
                                                                  .removeSelectedID(
                                                                      '${_provider.finalDataList[i][0]['id']}');
                                                            }
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
                                                            if (_provider
                                                                        .finalboolList[
                                                                    i][1] ==
                                                                false) {
                                                              setState(() {
                                                                _provider.finalboolList[
                                                                        i][1] =
                                                                    true;
                                                              });
                                                              _provider
                                                                  .addSelectedID(
                                                                      '${_provider.finalDataList[i][1]['id']}');
                                                            } else {
                                                              setState(() {
                                                                _provider.finalboolList[
                                                                        i][1] =
                                                                    false;
                                                              });
                                                              _provider
                                                                  .removeSelectedID(
                                                                      '${_provider.finalDataList[i][1]['id']}');
                                                            }
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
                                                            if (_provider
                                                                        .finalboolList[
                                                                    i][2] ==
                                                                false) {
                                                              setState(() {
                                                                _provider.finalboolList[
                                                                        i][2] =
                                                                    true;
                                                              });
                                                              _provider
                                                                  .addSelectedID(
                                                                      '${_provider.finalDataList[i][2]['id']}');
                                                            } else {
                                                              setState(() {
                                                                _provider.finalboolList[
                                                                        i][2] =
                                                                    false;
                                                              });
                                                              _provider
                                                                  .removeSelectedID(
                                                                      '${_provider.finalDataList[i][2]['id']}');
                                                            }
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
                                                            if (_provider
                                                                        .finalboolList[
                                                                    i][0] ==
                                                                false) {
                                                              setState(() {
                                                                _provider.finalboolList[
                                                                        i][0] =
                                                                    true;
                                                              });
                                                              _provider
                                                                  .addSelectedID(
                                                                      '${_provider.finalDataList[i][0]['id']}');
                                                            } else {
                                                              setState(() {
                                                                _provider.finalboolList[
                                                                        i][0] =
                                                                    false;
                                                              });
                                                              _provider
                                                                  .removeSelectedID(
                                                                      '${_provider.finalDataList[i][0]['id']}');
                                                            }
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
                                                            if (_provider
                                                                        .finalboolList[
                                                                    i][1] ==
                                                                false) {
                                                              setState(() {
                                                                _provider.finalboolList[
                                                                        i][1] =
                                                                    true;
                                                              });
                                                              _provider
                                                                  .addSelectedID(
                                                                      '${_provider.finalDataList[i][1]['id']}');
                                                            } else {
                                                              setState(() {
                                                                _provider.finalboolList[
                                                                        i][1] =
                                                                    false;
                                                              });
                                                              _provider
                                                                  .removeSelectedID(
                                                                      '${_provider.finalDataList[i][1]['id']}');
                                                            }
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
                                                            if (_provider
                                                                        .finalboolList[
                                                                    i][2] ==
                                                                false) {
                                                              setState(() {
                                                                _provider.finalboolList[
                                                                        i][2] =
                                                                    true;
                                                              });
                                                              _provider
                                                                  .addSelectedID(
                                                                      '${_provider.finalDataList[i][2]['id']}');
                                                            } else {
                                                              setState(() {
                                                                _provider.finalboolList[
                                                                        i][2] =
                                                                    false;
                                                              });
                                                              _provider
                                                                  .removeSelectedID(
                                                                      '${_provider.finalDataList[i][2]['id']}');
                                                            }
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
                                                            if (_provider
                                                                        .finalboolList[
                                                                    i][3] ==
                                                                false) {
                                                              setState(() {
                                                                _provider.finalboolList[
                                                                        i][3] =
                                                                    true;
                                                              });
                                                              _provider
                                                                  .addSelectedID(
                                                                      '${_provider.finalDataList[i][3]['id']}');
                                                            } else {
                                                              setState(() {
                                                                _provider.finalboolList[
                                                                        i][3] =
                                                                    false;
                                                              });
                                                              _provider
                                                                  .removeSelectedID(
                                                                      '${_provider.finalDataList[i][3]['id']}');
                                                            }
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
                                                    if (_provider.finalboolList[
                                                            i][0] ==
                                                        false) {
                                                      setState(() {
                                                        _provider.finalboolList[
                                                            i][0] = true;
                                                      });
                                                      _provider.addSelectedID(
                                                          '${_provider.finalDataList[i][0]['id']}');
                                                    } else {
                                                      setState(() {
                                                        _provider.finalboolList[
                                                            i][0] = false;
                                                      });
                                                      _provider.removeSelectedID(
                                                          '${_provider.finalDataList[i][0]['id']}');
                                                    }
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
                                                    if (_provider.finalboolList[
                                                            i][1] ==
                                                        false) {
                                                      setState(() {
                                                        _provider.finalboolList[
                                                            i][1] = true;
                                                      });
                                                      _provider.addSelectedID(
                                                          '${_provider.finalDataList[i][1]['id']}');
                                                    } else {
                                                      setState(() {
                                                        _provider.finalboolList[
                                                            i][1] = false;
                                                      });
                                                      _provider.removeSelectedID(
                                                          '${_provider.finalDataList[i][1]['id']}');
                                                    }
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
                                                    if (_provider.finalboolList[
                                                            i][2] ==
                                                        false) {
                                                      setState(() {
                                                        _provider.finalboolList[
                                                            i][2] = true;
                                                      });
                                                      _provider.addSelectedID(
                                                          '${_provider.finalDataList[i][2]['id']}');
                                                    } else {
                                                      setState(() {
                                                        _provider.finalboolList[
                                                            i][2] = false;
                                                      });
                                                      _provider.removeSelectedID(
                                                          '${_provider.finalDataList[i][2]['id']}');
                                                    }
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
                                                    if (_provider.finalboolList[
                                                            i][3] ==
                                                        false) {
                                                      setState(() {
                                                        _provider.finalboolList[
                                                            i][3] = true;
                                                      });
                                                      _provider.addSelectedID(
                                                          '${_provider.finalDataList[i][3]['id']}');
                                                    } else {
                                                      setState(() {
                                                        _provider.finalboolList[
                                                            i][3] = false;
                                                      });
                                                      _provider.removeSelectedID(
                                                          '${_provider.finalDataList[i][3]['id']}');
                                                    }
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
                                                    if (_provider.finalboolList[
                                                            i][0] ==
                                                        false) {
                                                      setState(() {
                                                        _provider.finalboolList[
                                                            i][0] = true;
                                                      });
                                                      _provider.addSelectedID(
                                                          '${_provider.finalDataList[i][0]['id']}');
                                                    } else {
                                                      setState(() {
                                                        _provider.finalboolList[
                                                            i][0] = false;
                                                      });
                                                      _provider.removeSelectedID(
                                                          '${_provider.finalDataList[i][0]['id']}');
                                                    }
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
                                                    if (_provider.finalboolList[
                                                            i][1] ==
                                                        false) {
                                                      setState(() {
                                                        _provider.finalboolList[
                                                            i][1] = true;
                                                      });
                                                      _provider.addSelectedID(
                                                          '${_provider.finalDataList[i][1]['id']}');
                                                    } else {
                                                      setState(() {
                                                        _provider.finalboolList[
                                                            i][1] = false;
                                                      });
                                                      _provider.removeSelectedID(
                                                          '${_provider.finalDataList[i][1]['id']}');
                                                    }
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
                                                    if (_provider.finalboolList[
                                                            i][2] ==
                                                        false) {
                                                      setState(() {
                                                        _provider.finalboolList[
                                                            i][2] = true;
                                                      });
                                                      _provider.addSelectedID(
                                                          '${_provider.finalDataList[i][2]['id']}');
                                                    } else {
                                                      setState(() {
                                                        _provider.finalboolList[
                                                            i][2] = false;
                                                      });
                                                      _provider.removeSelectedID(
                                                          '${_provider.finalDataList[i][2]['id']}');
                                                    }
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
                      child: InkWell(
                        splashColor: Colors.white,
                        highlightColor: Colors.white,
                        onTap: () {
                          if (_provider.isloading == false) {
                            if (_provider.listSelectedId.length >= 1) {
                              _provider.setisloading(true);
                              ApiUtils.sendSlectedTaskData(
                                  provider: _provider,
                                  scaffoldkey: _provider.scaffoldKey);
                            }
                          }
                        },
                        child: Container(
                          height: height / 14,
                          width: width,
                          child: Center(
                            child: _provider.isloading == false
                                ? Text(
                                    'Next',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  )
                                : CupertinoActivityIndicator(),
                          ),
                          decoration: BoxDecoration(
                              color: ColorsThemes.mailColors,
                              borderRadius: BorderRadius.circular(8)),
                          margin: EdgeInsets.only(
                              top: width / 20,
                              left: width / 10,
                              right: width / 10),
                        ),
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
            _provider.isanim == false
                ? SizedBox()
                : Container(
                    height: height,
                    width: width,
                    child: Center(
                      child: Image.asset(
                        'assets/DefaultTaskGif.gif',
                        color: Colors.white,
                      ),
                    ),
                    decoration:
                        BoxDecoration(color: Colors.black.withOpacity(0.5)),
                  )
          ],
        ),
      ),
    );
  }
}

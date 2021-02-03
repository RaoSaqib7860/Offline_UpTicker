import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:upticker/ApiConfig/APiUtil.dart';
import 'package:upticker/ColorsThems/ThemesColors.dart';
import 'package:upticker/Provider/BlockAddCustomTask.dart';
import 'package:upticker/Provider/BlockCalenderList.dart';
import 'package:upticker/ServicesForApp/FireBaseAnalytics.dart';

import 'AddCustomTask.dart';
import 'CreateCustomTask.dart';

class AdditionalSubMentorTask extends StatefulWidget {
  AdditionalSubMentorTask({Key key, this.id}) : super(key: key);
  final String id;

  @override
  _AdditionalSubMentorTaskState createState() =>
      _AdditionalSubMentorTaskState();
}

class _AdditionalSubMentorTaskState extends State<AdditionalSubMentorTask> {
  @override
  void initState() {
    final BlockAdditionalSubMentroTask _provider =
        Provider.of<BlockAdditionalSubMentroTask>(context, listen: false);
    FireBaseAnalyticsServices.setCurrentScreen(
        screenClass: 'Mentors task class', screenName: 'Mentors task');
    apiCalling(_provider);
    super.initState();
  }

  apiCalling(BlockAdditionalSubMentroTask provider) async {
    await ApiUtils.getSubAdditionalSubBucketData(
        provider: provider, id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final BlockAdditionalSubMentroTask _provider =
        Provider.of<BlockAdditionalSubMentroTask>(
      context,
    );
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
                          : _provider.customBucketData.length == 0
                              ? Center(child: Text('No Data'))
                              : ListView.builder(
                                  itemBuilder: (c, i) {
                                    return FlipInX(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: width / 20,
                                            right: width / 20),
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
                                                  SizedBox(
                                                    width: width / 30,
                                                  ),
                                                  Text(
                                                    '${_provider.customBucketData[i]['name']}',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        letterSpacing: 0.5,
                                                        color: ColorsThemes
                                                            .lightBlackColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              splashColor: Colors.white,
                                              highlightColor: Colors.white,
                                              onTap: () {
                                                print(
                                                  '${_provider.customBucketData[i]['id']}',
                                                );
                                                _provider.setaddsubbucketList(
                                                    '${_provider.customBucketData[i]['id']}');
                                                _provider
                                                    .setloadingaddtask(true);
                                                ApiUtils.addAditionalMentorData(
                                                    provider: _provider,
                                                    scaffoldkey:
                                                        _provider.scaffoldKey);
                                              },
                                              child: Icon(Icons.add,
                                                  color: ColorsThemes
                                                      .ringThemeColor),
                                            ),
                                          ],
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
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
            ),
            _provider.loadingaddtask == false
                ? Container()
                : Container(
                    height: height,
                    width: width,
                    child: Center(child: CircularProgressIndicator()),
                    decoration:
                        BoxDecoration(color: Colors.black.withOpacity(0.5)),
                  )
          ],
        ),
      ),
    );
  }
}

class BlockAdditionalSubMentroTask extends ChangeNotifier {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  List _customsubBucketData = [];

  List get customBucketData => _customsubBucketData;

  setCustomSubBucketData(List data) {
    _customsubBucketData = data;
  }

  List _addsubbucketList = [];

  List get subbucketList => _addsubbucketList;

  setaddsubbucketList(String id) {
    _addsubbucketList.add(int.parse(id));
  }

  bool _loading = false;

  bool get loading => _loading;

  setLoading() {
    _loading = true;
    notifyListeners();
  }

  bool _loadingaddtask = false;

  bool get loadingaddtask => _loadingaddtask;

  setloadingaddtask(bool v) {
    _loadingaddtask = v;
    notifyListeners();
  }
}

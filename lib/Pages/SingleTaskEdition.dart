import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:upticker/ApiConfig/APiUtil.dart';
import 'package:upticker/ColorsThems/ThemesColors.dart';
import 'package:upticker/Provider/BlockSettings.dart';
import 'package:upticker/Provider/BlockSinglePageEdition.dart';
import 'package:upticker/ServicesForApp/FireBaseAnalytics.dart';
import 'Settings.dart';

class SingleTaskEdition extends StatefulWidget {
  @override
  _SingleTaskEditionState createState() => _SingleTaskEditionState();
}

class _SingleTaskEditionState extends State<SingleTaskEdition> {
  @override
  void initState() {
    final provider =
        Provider.of<BlockSinglePageEdition>(context, listen: false);
    getApiData(provider);
    FireBaseAnalyticsServices.setCurrentScreen(
        screenName: 'Edit task', screenClass: 'Edit task class');
    super.initState();
  }

  getApiData(BlockSinglePageEdition provider) {
    ApiUtils.getSingleEditionTask(provider: provider);
  }

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<BlockSinglePageEdition>(
      context,
    );
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        key: _provider.scaffoldKey,
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(height / 7.5),
          child: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(color: Colors.white),
              height: height / 7.5,
              child: Container(
                height: height / 7.5,
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
                            'Edit Task',
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
        body: Padding(
          padding: EdgeInsets.only(left: width / 20, right: width / 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: height / 30,
              ),
              Expanded(
                child: _provider.loading == false
                    ? Center(
                        child: CupertinoActivityIndicator(),
                      )
                    : ListView.builder(
                        itemBuilder: (c, i) {
                          return FlipInY(
                            child: Container(
                              height: height / 15,
                              margin: EdgeInsets.only(bottom: height / 50),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          duration: Duration(milliseconds: 500),
                                          type: PageTransitionType.rightToLeft,
                                          child: ChangeNotifierProvider(
                                            create: (_) => BlockSettings(),
                                            child: Settings(
                                              id: '${_provider.listoftask[i]['id']}',
                                              index: i,
                                              aditSingle: true,
                                              taskName:
                                                  '${_provider.listoftask[i]['name']}',
                                            ),
                                          )));
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: width / 30),
                                      child: Text(
                                        '${_provider.listoftask[i]['name']}',
                                        style: TextStyle(
                                            fontSize: 14, letterSpacing: 0.5),
                                      ),
                                    ),
                                    IconButton(
                                        icon: Icon(
                                          Icons.edit,
                                          size: 20,
                                          color: Colors.blue,
                                        ),
                                        onPressed: null)
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: ColorsThemes.offGraycolor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(.11),
                                      blurRadius: 3,
                                      offset: Offset(
                                        3.0,
                                        5.0,
                                      ),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(7)),
                            ),
                          );
                        },
                        itemCount: _provider.listoftask.length,
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

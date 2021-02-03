import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:upticker/ApiConfig/APiUtil.dart';
import 'package:upticker/ColorsThems/ThemesColors.dart';
import 'package:upticker/Pages/WriteJournalPage.dart';
import 'package:upticker/Provider/BlockJournel.dart';
import 'package:upticker/Provider/BlockWriteJournalPage.dart';
import 'package:upticker/ServicesForApp/FireBaseAnalytics.dart';

class JournalPage extends StatefulWidget {
  JournalPage({Key key}) : super(key: key);

  @override
  _JournalPageState createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  @override
  void initState() {
    final BlockJournal _provider =
        Provider.of<BlockJournal>(context, listen: false);
    _provider.getCurrentDate(DateTime.now());
    FireBaseAnalyticsServices.setCurrentScreen(
        screenClass: 'Journal class', screenName: 'Journal');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final BlockJournal _provider = Provider.of<BlockJournal>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height / 6.3),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(color: Colors.white),
            margin: EdgeInsets.only(top: height / 100),
            height: height / 6.3,
            child: FadeInDown(
              delay: Duration(milliseconds: 600),
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
                            'Journal',
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
                        splashColor: Colors.white,
                        highlightColor: Colors.white,
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
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
        ),
      ),
      body: Container(
        height: height,
        width: width,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: height / 30,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: height / 30,
              ),
            ),
            SliverToBoxAdapter(
              child: InkWell(
                splashColor: Colors.white,
                highlightColor: Colors.white,
                onTap: () {
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      maxTime: DateTime(2070, 6, 7),
                      theme: DatePickerTheme(
                          headerColor: Colors.white,
                          backgroundColor: Colors.white,
                          itemStyle:
                              TextStyle(color: Colors.black, fontSize: 12),
                          doneStyle: TextStyle(
                              color: Colors.blue,
                              fontSize: 14,
                              fontWeight: FontWeight.bold)),
                      onChanged: (date) {}, onConfirm: (date) {
                    _provider.replaceDate();
                    _provider.setupdate(true);
                    _provider.getCurrentDate(date);
                  }, currentTime: DateTime.now(), locale: LocaleType.en);
                },
                hoverColor: Colors.white,
                focusColor: Colors.white,
                child: Container(
                  margin: EdgeInsets.only(left: width / 10, right: width / 10),
                  height: height / 15,
                  width: width,
                  child: Center(
                    child: Text(
                      'Select Date',
                      style: TextStyle(
                          color: ColorsThemes.lightBlackColor,
                          letterSpacing: 0.5,
                          fontSize: 12),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: ColorsThemes.offGraycolor,
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: height / 30,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return InkWell(
                    splashColor: Colors.white,
                    highlightColor: Colors.white,
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              duration: Duration(milliseconds: 500),
                              type: PageTransitionType.rightToLeft,
                              child: ChangeNotifierProvider(
                                create: (_) => BlockWriteJpournalPage(),
                                child: WriteJournalPage(
                                  date: '${_provider.serverFormatdate[index]}',
                                ),
                              )));
                    },
                    child: FlipInY(
                      duration: Duration(seconds: 1),
                      delay: Duration(milliseconds: 600),
                      child: Container(
                        height: height / 12,
                        width: width,
                        margin: EdgeInsets.only(bottom: height / 50),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: height / 14,
                                width: width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: width / 5,
                                    ),
                                    Text('${_provider.day[index]}'),
                                  ],
                                ),
                                margin: EdgeInsets.only(
                                    left: width / 6, right: width / 10),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 3,
                                        color: Colors.blueGrey[100],
                                      )
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: EdgeInsets.only(left: width / 10),
                                height: double.infinity,
                                width: width / 6,
                                decoration: BoxDecoration(
                                    color: ColorsThemes.darkThemeColor,
                                    shape: BoxShape.circle),
                                child: Center(
                                  child: Text(
                                    '${_provider.date[index]}',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                childCount: _provider.date.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}

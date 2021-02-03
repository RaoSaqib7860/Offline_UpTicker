import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:upticker/ColorsThems/ThemesColors.dart';

class NoteDetailPage extends StatefulWidget {
  NoteDetailPage({Key key, this.titlel, this.dic}) : super(key: key);
  final String titlel;
  final String dic;
  @override
  _NoteDetailPageState createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(height / 6.3),
            child: AppBar(
              flexibleSpace: Container(
                decoration: BoxDecoration(color: Colors.white),
                margin: EdgeInsets.only(),
                height: height / 6.3,
                child: FadeInDown(
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
                          child: Container(
                            padding: EdgeInsets.only(top: height / 30),
                            child: Center(
                              child: Text(
                                'Note Details',
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
                              Navigator.of(context).pop();
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
          backgroundColor: Colors.white,
          body: Container(
            height: height,
            width: width,
            padding: EdgeInsets.only(left: width / 15, right: width / 15),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: height / 30,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Title',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('${widget.titlel}',
                        style: TextStyle(fontSize: 13, color: Colors.black38)),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: height / 30,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Discription',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('${widget.dic}',
                        style: TextStyle(fontSize: 13, color: Colors.black38)),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

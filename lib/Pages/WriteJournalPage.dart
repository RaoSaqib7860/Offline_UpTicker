import 'dart:async';
import 'dart:io' as io;
import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:record_mp3/record_mp3.dart';
import 'package:upticker/ApiConfig/APiUtil.dart';
import 'package:upticker/ColorsThems/ThemesColors.dart';
import 'package:upticker/LocalWidget/LocalWidget.dart';
import 'package:upticker/Pages/AudioPlayerClass.dart';
import 'package:upticker/Provider/BlockWriteJournalPage.dart';
import 'package:upticker/Pages/NoteDetailPage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:upticker/ServicesForApp/FireBaseAnalytics.dart';

class WriteJournalPage extends StatefulWidget {
  WriteJournalPage({Key key, this.date}) : super(key: key);
  final String date;

  @override
  _WriteJournalPageState createState() => _WriteJournalPageState();
}

class _WriteJournalPageState extends State<WriteJournalPage> {
  String statusText = "";
  bool isComplete = false;
  bool isrecord = false;

  @override
  void initState() {
    final BlockWriteJpournalPage _provider =
        Provider.of<BlockWriteJpournalPage>(context, listen: false);
    checkPermission();
    apiCalling(_provider);
    FireBaseAnalyticsServices.setCurrentScreen(
        screenClass: 'Journal events perform class',
        screenName: 'Journal event');
    super.initState();
  }

  apiCalling(BlockWriteJpournalPage provider) async {
    await ApiUtils.getJouralData(date: widget.date, provider: provider);
  }

  Future onBackPress(BlockWriteJpournalPage _provider) async {
    stopRecord(_provider);
    if (_provider.file != null || _provider.imageFile != null) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            var height = MediaQuery.of(context).size.height;
            var width = MediaQuery.of(context).size.width;
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)), //this right here
              child: Container(
                height: height / 5,
                width: width,
                child: Column(
                  children: [
                    Text(
                      'Do you want to save all data .',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: height / 55,
                    ),
                    Padding(
                      padding: EdgeInsets.all(width / 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            splashColor: Colors.white,
                            highlightColor: Colors.white,
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              height: height / 18,
                              width: width / 5,
                              child: Center(
                                child: Text('Cancel'),
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey[100],
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Colors.black26, width: 1)),
                            ),
                          ),
                          SizedBox(
                            width: width / 10,
                          ),
                          InkWell(
                            splashColor: Colors.white,
                            highlightColor: Colors.white,
                            onTap: () {
                              if (_provider.file != null) {
                                ApiUtils.postJournalAudioData(
                                    id: _provider.finalList['id'],
                                    provider: _provider,
                                    date: widget.date);
                                _provider.setLoading(false);
                              }
                              if (_provider.imageFile != null) {
                                ApiUtils.postJournalImageData(
                                    id: _provider.finalList['id'],
                                    provider: _provider,
                                    date: widget.date);
                                _provider.setLoading(false);
                              }
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              height: height / 18,
                              width: width / 5,
                              child: Center(
                                child: Text(
                                  'Save',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey[100],
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Colors.black26, width: 1)),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
              ),
            );
          });
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final BlockWriteJpournalPage _provider =
        Provider.of<BlockWriteJpournalPage>(
      context,
    );
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () => onBackPress(_provider),
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: Column(
          children: [
            _provider.current != 'music'
                ? Container(
                    height: height / 13,
                    width: width / 6.5,
                    margin: EdgeInsets.only(right: width / 20),
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle))
                : InkWell(
                    splashColor: Colors.white,
                    highlightColor: Colors.white,
                    onLongPress: () {
                      setState(() {
                        isrecord = true;
                      });
                      startRecord();
                    },
                    onTap: () {
                      if (isrecord == true) {
                        setState(() {
                          isrecord = false;
                        });
                        stopRecord(_provider);
                      }
                    },
                    child: Container(
                      height: height / 13,
                      width: width / 6.5,
                      child: isrecord == false
                          ? Icon(
                              Icons.keyboard_voice,
                              color: Colors.white,
                            )
                          : Image.asset(
                              'assets/gifRecording.gif',
                            ),
                      margin: EdgeInsets.only(right: width / 20),
                      decoration: BoxDecoration(
                          color: isrecord == false
                              ? ColorsThemes.mailColors
                              : Colors.white,
                          shape: BoxShape.circle),
                    ),
                  ),
            SizedBox(
              height: height / 60,
            ),
            Container(
              margin: EdgeInsets.only(right: width / 15),
              child: FloatingActionButton(
                backgroundColor: ColorsThemes.mailColors,
                onPressed: () {
                  if (_provider.floatingText == 'add audio') {
                    _provider.pickAudio();
                  } else if (_provider.floatingText == 'add image') {
                    displayBottomSheet(context, _provider);
                  } else {
                    _provider.nameCon.clear();
                    _provider.disCon.clear();
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20.0)), //this right here
                            child: Container(
                              height: height / 1.8,
                              child: ListView(
                                children: [
                                  SizedBox(
                                    height: height / 50,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: width / 30, right: width / 30),
                                    height: height / 15,
                                    width: width,
                                    decoration: BoxDecoration(
                                        color: ColorsThemes.offGraycolor,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: TextFormField(
                                      controller: _provider.nameCon,
                                      textInputAction: TextInputAction.done,
                                      decoration: InputDecoration(
                                          hintText: 'Note Title Here',
                                          hintStyle: TextStyle(fontSize: 12),
                                          border: InputBorder.none,
                                          contentPadding:
                                              EdgeInsets.all(width / 30)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height / 50,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: width / 30, right: width / 30),
                                    height: height / 3,
                                    width: width,
                                    decoration: BoxDecoration(
                                        color: ColorsThemes.offGraycolor,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: TextFormField(
                                      maxLines: 10,
                                      controller: _provider.disCon,
                                      textInputAction: TextInputAction.done,
                                      decoration: InputDecoration(
                                          hintText: 'Note Description Here',
                                          hintStyle: TextStyle(fontSize: 12),
                                          border: InputBorder.none,
                                          contentPadding:
                                              EdgeInsets.all(width / 30)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height / 50,
                                  ),
                                  InkWell(
                                    splashColor: Colors.white,
                                    highlightColor: Colors.white,
                                    onTap: () {
                                      if (_provider.nameCon.text.isNotEmpty &&
                                          _provider.disCon.text.isNotEmpty) {
                                        ApiUtils.postJournalNoteData(
                                            id: _provider.finalList['id'],
                                            provider: _provider);
                                        Navigator.of(context).pop();
                                        _provider.setLoading(false);
                                        apiCalling(_provider);
                                      }
                                    },
                                    child: Container(
                                      height: height / 16,
                                      margin: EdgeInsets.only(
                                          left: width / 4, right: width / 4),
                                      child: Center(
                                          child: Text(
                                        'Add',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                      decoration: BoxDecoration(
                                          color: ColorsThemes.mailColors,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  }
                },
                child: Text(
                  '${_provider.floatingText}',
                  style: TextStyle(color: Colors.white, fontSize: 8),
                ),
              ),
            ),
            SizedBox(
              height: height / 7.5,
            )
          ],
          mainAxisAlignment: MainAxisAlignment.end,
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(height / 6.3),
          child: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(color: Colors.white),
              margin: EdgeInsets.only(top: height / 100),
              height: height / 6.3,
              child: FadeInDown(
                delay: Duration(milliseconds: 400),
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
                              'Write Journal',
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
                            onBackPress(_provider);
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
            child: ListView(
              children: [
                SizedBox(
                  height: height / 60,
                ),
                Container(
                  height: height / 1.530,
                  width: width,
                  child: _provider.loading == false
                      ? Center(
                          child: CupertinoActivityIndicator(),
                        )
                      : _provider.current == 'music'
                          ? ListView(
                              children: [
                                SizedBox(
                                  height: height / 30,
                                ),
                                _provider.file != null
                                    ? Container(
                                        height: height / 20,
                                        decoration: BoxDecoration(
                                            color: Colors.blueGrey[100]),
                                        child: Row(
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: width / 10,
                                                ),
                                                Icon(Icons.play_arrow,
                                                    color: Colors.black),
                                                SizedBox(
                                                  width: width / 30,
                                                ),
                                                Text(
                                                  'This is Sound',
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  width: width / 3,
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: InkWell(
                                                    splashColor: Colors.white,
                                                    highlightColor:
                                                        Colors.white,
                                                    onTap: () {
                                                      ApiUtils
                                                          .postJournalAudioData(
                                                              id: _provider
                                                                      .finalList[
                                                                  'id'],
                                                              provider:
                                                                  _provider,
                                                              date:
                                                                  widget.date);
                                                      _provider
                                                          .setLoading(false);
                                                    },
                                                    child: Text(
                                                      'Save',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.blue,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                )
                                              ],
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(),
                                SizedBox(
                                  height: height / 30,
                                ),
                                Container(
                                  height: height / 1.3,
                                  width: width,
                                  child: _provider.audiolist.length == 0
                                      ? Center(
                                          child: Text('Audio not available'),
                                        )
                                      : ListView.builder(
                                          itemBuilder: (c, i) {
                                            return Column(
                                              children: [
                                                InkWell(
                                                  splashColor: Colors.white,
                                                  highlightColor: Colors.white,
                                                  onTap: () {
                                                    // Navigator.push(
                                                    //     context,
                                                    //     MaterialPageRoute(
                                                    //         builder: (c) =>
                                                    //             AudioPlayerClass(
                                                    //               url: _provider
                                                    //                       .audiolist[i]
                                                    //                   ['audio'],
                                                    //             )));
                                                    openDailog(
                                                      url:
                                                          _provider.audiolist[i]
                                                              ['audio'],
                                                    );
                                                  },
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: width / 10,
                                                      ),
                                                      Icon(Icons.play_arrow,
                                                          color: Colors.black),
                                                      SizedBox(
                                                        width: width / 30,
                                                      ),
                                                      Text(
                                                        'This is Sound',
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        width: width / 2.6,
                                                      ),
                                                      InkWell(
                                                        splashColor:
                                                            Colors.white,
                                                        highlightColor:
                                                            Colors.white,
                                                        onTap: () {
                                                          ApiUtils.deleteJournalAudioData(
                                                              id: _provider
                                                                      .audiolist[
                                                                  i]['id'],
                                                              index: i,
                                                              provider:
                                                                  _provider);
                                                        },
                                                        child: Icon(
                                                            Icons.delete,
                                                            color: Colors
                                                                .red[100]),
                                                      )
                                                    ],
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: height / 40,
                                                )
                                              ],
                                            );
                                          },
                                          itemCount: _provider.audiolist == null
                                              ? 0
                                              : _provider.audiolist.length,
                                        ),
                                ),
                              ],
                            )
                          : _provider.current == 'image'
                              ? _provider.listimages.length == 0
                                  ? _provider.imageFile != null
                                      ? Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  bottom: height / 2.5),
                                              height: height / 5,
                                              width: width / 2.5,
                                              child: Stack(
                                                children: [
                                                  Container(
                                                      height: double.infinity,
                                                      width: double.infinity,
                                                      child: Image.file(
                                                        io.File(_provider
                                                            .imageFile.path),
                                                        fit: BoxFit.cover,
                                                      )),
                                                  Container(
                                                    height: double.infinity,
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                        gradient: LinearGradient(
                                                            colors: [
                                                          Colors.white
                                                              .withOpacity(0.0),
                                                          Colors.black
                                                              .withOpacity(0.8)
                                                        ],
                                                            begin: Alignment
                                                                .topCenter,
                                                            end: Alignment
                                                                .bottomCenter)),
                                                  ),
                                                  InkWell(
                                                    splashColor: Colors.white,
                                                    highlightColor:
                                                        Colors.white,
                                                    onTap: () {
                                                      ApiUtils
                                                          .postJournalImageData(
                                                              id: _provider
                                                                      .finalList[
                                                                  'id'],
                                                              provider:
                                                                  _provider,
                                                              date:
                                                                  widget.date);
                                                      _provider
                                                          .setLoading(false);
                                                    },
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: double.infinity,
                                                      child: Column(
                                                        children: [
                                                          Icon(Icons.add,
                                                              size: 30,
                                                              color:
                                                                  Colors.white),
                                                          Text(
                                                            'Add Image',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )
                                                        ],
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              decoration: BoxDecoration(
                                                  color: Colors.blueGrey[100]),
                                            ),
                                          ],
                                        )
                                      : Center(
                                          child: Text('Images not available'),
                                        )
                                  : ListView(
                                      children: [
                                        _provider.imageFile != null
                                            ? FlipInY(
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: height / 50),
                                                      height: height / 5,
                                                      width: width / 2.5,
                                                      child: Stack(
                                                        children: [
                                                          Container(
                                                              height: double
                                                                  .infinity,
                                                              width: double
                                                                  .infinity,
                                                              child: Image.file(
                                                                io.File(_provider
                                                                    .imageFile
                                                                    .path),
                                                                fit: BoxFit
                                                                    .cover,
                                                              )),
                                                          Container(
                                                            height:
                                                                double.infinity,
                                                            width:
                                                                double.infinity,
                                                            decoration: BoxDecoration(
                                                                gradient: LinearGradient(
                                                                    colors: [
                                                                  Colors.white
                                                                      .withOpacity(
                                                                          0.0),
                                                                  Colors.black
                                                                      .withOpacity(
                                                                          0.8)
                                                                ],
                                                                    begin: Alignment
                                                                        .topCenter,
                                                                    end: Alignment
                                                                        .bottomCenter)),
                                                          ),
                                                          InkWell(
                                                            splashColor:
                                                                Colors.white,
                                                            highlightColor:
                                                                Colors.white,
                                                            onTap: () {
                                                              ApiUtils.postJournalImageData(
                                                                  id: _provider
                                                                          .finalList[
                                                                      'id'],
                                                                  provider:
                                                                      _provider,
                                                                  date: widget
                                                                      .date);
                                                              _provider
                                                                  .setLoading(
                                                                      false);
                                                            },
                                                            child: Container(
                                                              width: double
                                                                  .infinity,
                                                              height: double
                                                                  .infinity,
                                                              child: Column(
                                                                children: [
                                                                  Icon(
                                                                      Icons.add,
                                                                      size: 30,
                                                                      color: Colors
                                                                          .white),
                                                                  Text(
                                                                    'Add Image',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  )
                                                                ],
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .blueGrey[100]),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                        Container(
                                          height: height / 1.530,
                                          width: width,
                                          child: StaggeredGridView.countBuilder(
                                            crossAxisCount: 4,
                                            itemCount: _provider.listimages ==
                                                    null
                                                ? 0
                                                : _provider.listimages.length,
                                            itemBuilder: (BuildContext context,
                                                    int index) =>
                                                FlipInX(
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    height: double.infinity,
                                                    width: double.infinity,
                                                    color: Colors.blueGrey[50],
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          "${_provider.listimages[index]['image']}",
                                                      placeholder: (context,
                                                              url) =>
                                                          CupertinoActivityIndicator(),
                                                      fit: BoxFit.cover,
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(Icons.error),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: InkWell(
                                                      splashColor: Colors.white,
                                                      highlightColor:
                                                          Colors.white,
                                                      onTap: () {
                                                        ApiUtils.deleteJournalImageData(
                                                            id: _provider
                                                                    .listimages[
                                                                index]['id'],
                                                            index: index,
                                                            provider:
                                                                _provider);
                                                      },
                                                      child: Icon(Icons.cancel,
                                                          color: Colors.white),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            staggeredTileBuilder: (int index) =>
                                                new StaggeredTile.count(
                                                    2, index.isEven ? 2 : 1.4),
                                            mainAxisSpacing: 4.0,
                                            crossAxisSpacing: 4.0,
                                          ),
                                        ),
                                      ],
                                    )
                              : _provider.listnote.length == 0
                                  ? Center(
                                      child: Text('Note not available'),
                                    )
                                  : ListView.builder(
                                      itemBuilder: (c, i) => FlipInY(
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: height / 50,
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: height / 60,
                                                ),
                                                InkWell(
                                                    splashColor: Colors.white,
                                                    highlightColor:
                                                        Colors.white,
                                                    onTap: () {
                                                      _provider.nameCon.clear();
                                                      _provider.disCon.clear();
                                                      _provider.disCon.text =
                                                          '${_provider.listnote[i]['description']}';
                                                      _provider.nameCon.text =
                                                          '${_provider.listnote[i]['name']}';

                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return Dialog(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20.0)),
                                                              //this right here
                                                              child: Container(
                                                                height: height /
                                                                    1.8,
                                                                child: ListView(
                                                                  children: [
                                                                    SizedBox(
                                                                      height:
                                                                          height /
                                                                              50,
                                                                    ),
                                                                    Container(
                                                                      margin: EdgeInsets.only(
                                                                          left: width /
                                                                              30,
                                                                          right:
                                                                              width / 30),
                                                                      height:
                                                                          height /
                                                                              15,
                                                                      width:
                                                                          width,
                                                                      decoration: BoxDecoration(
                                                                          color: ColorsThemes
                                                                              .offGraycolor,
                                                                          borderRadius:
                                                                              BorderRadius.circular(8)),
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            _provider.nameCon,
                                                                        textInputAction:
                                                                            TextInputAction.done,
                                                                        decoration: InputDecoration(
                                                                            hintText:
                                                                                'Note Title Here',
                                                                            hintStyle:
                                                                                TextStyle(fontSize: 12),
                                                                            border: InputBorder.none,
                                                                            contentPadding: EdgeInsets.all(width / 30)),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          height /
                                                                              50,
                                                                    ),
                                                                    Container(
                                                                      margin: EdgeInsets.only(
                                                                          left: width /
                                                                              30,
                                                                          right:
                                                                              width / 30),
                                                                      height:
                                                                          height /
                                                                              3,
                                                                      width:
                                                                          width,
                                                                      decoration: BoxDecoration(
                                                                          color: ColorsThemes
                                                                              .offGraycolor,
                                                                          borderRadius:
                                                                              BorderRadius.circular(8)),
                                                                      child:
                                                                          TextFormField(
                                                                        maxLines:
                                                                            10,
                                                                        controller:
                                                                            _provider.disCon,
                                                                        textInputAction:
                                                                            TextInputAction.done,
                                                                        decoration: InputDecoration(
                                                                            hintText:
                                                                                'Note Description Here',
                                                                            hintStyle:
                                                                                TextStyle(fontSize: 12),
                                                                            border: InputBorder.none,
                                                                            contentPadding: EdgeInsets.all(width / 30)),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          height /
                                                                              50,
                                                                    ),
                                                                    InkWell(
                                                                      splashColor:
                                                                          Colors
                                                                              .white,
                                                                      highlightColor:
                                                                          Colors
                                                                              .white,
                                                                      onTap:
                                                                          () {
                                                                        if (_provider.nameCon.text.isNotEmpty &&
                                                                            _provider.disCon.text.isNotEmpty) {
                                                                          ApiUtils.updateJournalNoteData(
                                                                              id: _provider.listnote[i]['id'],
                                                                              provider: _provider);
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                          _provider
                                                                              .setLoading(false);
                                                                          apiCalling(
                                                                              _provider);
                                                                        }
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            height /
                                                                                16,
                                                                        margin: EdgeInsets.only(
                                                                            left: width /
                                                                                4,
                                                                            right:
                                                                                width / 4),
                                                                        child: Center(
                                                                            child: Text(
                                                                          'Add',
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        )),
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                ColorsThemes.mailColors,
                                                                            borderRadius: BorderRadius.circular(8)),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          });
                                                    },
                                                    child: Icon(Icons.edit,
                                                        color: Colors.black38)),
                                                InkWell(
                                                  splashColor: Colors.white,
                                                  highlightColor: Colors.white,
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (c) =>
                                                                NoteDetailPage(
                                                                  titlel:
                                                                      '${_provider.listnote[i]['name']}',
                                                                  dic:
                                                                      '${_provider.listnote[i]['description']}',
                                                                )));
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: width / 50,
                                                        right: width / 50),
                                                    height: height / 15,
                                                    width: width / 1.3,
                                                    child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          '  ${_provider.listnote[i]['name']}',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 14),
                                                        )),
                                                    decoration: BoxDecoration(
                                                        color: ColorsThemes
                                                            .offGraycolor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                  ),
                                                ),
                                                InkWell(
                                                    splashColor: Colors.white,
                                                    highlightColor:
                                                        Colors.white,
                                                    onTap: () {
                                                      ApiUtils
                                                          .deleteJournalNoteData(
                                                              id: _provider
                                                                      .listnote[
                                                                  i]['id'],
                                                              provider:
                                                                  _provider,
                                                              index: i);
                                                    },
                                                    child: Icon(Icons.delete,
                                                        color: Colors.red[100]))
                                              ],
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                            ),
                                          ],
                                        ),
                                      ),
                                      itemCount: _provider.listnote == null
                                          ? null
                                          : _provider.listnote.length,
                                    ),
                  decoration: BoxDecoration(),
                ),
                SizedBox(
                  height: height / 50,
                ),
                Container(
                  padding: EdgeInsets.only(left: width / 10, right: width / 10),
                  child: Row(
                    children: [
                      InkWell(
                        splashColor: Colors.white,
                        highlightColor: Colors.white,
                        onTap: () {
                          _provider.setCurrent('image');
                          _provider.setfloatingText('add image');
                        },
                        child: _provider.current == 'image'
                            ? ElasticInDown(
                                child: Container(
                                  height: height / 11,
                                  width: width / 5.5,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: ColorsThemes.mailColors),
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : ElasticInLeft(
                                delay: Duration(milliseconds: 1000),
                                child: Container(
                                  height: height / 10,
                                  width: width / 5,
                                  child:
                                      Image.asset('assets/CameraJournal.png'),
                                ),
                              ),
                      ),
                      InkWell(
                        splashColor: Colors.white,
                        highlightColor: Colors.white,
                        onTap: () {
                          _provider.setCurrent('music');
                          _provider.setfloatingText('add audio');
                        },
                        child: _provider.current == 'music'
                            ? BounceInUp(
                                child: Container(
                                  height: height / 11,
                                  width: width / 5.5,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: ColorsThemes.mailColors),
                                  child: Icon(
                                    Icons.settings_voice,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : ElasticInDown(
                                delay: Duration(milliseconds: 500),
                                child: Container(
                                  height: height / 10,
                                  width: width / 5,
                                  child:
                                      Image.asset('assets/speakerJournal.png'),
                                ),
                              ),
                      ),
                      InkWell(
                        splashColor: Colors.white,
                        highlightColor: Colors.white,
                        onTap: () {
                          _provider.setCurrent('note');
                          _provider.setfloatingText('add note');
                        },
                        child: _provider.current == 'note'
                            ? FadeInRight(
                                delay: Duration(milliseconds: 1000),
                                child: Container(
                                  height: height / 11,
                                  width: width / 5.5,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: ColorsThemes.mailColors),
                                  child: Icon(
                                    Icons.event_note,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : ElasticInRight(
                                child: Container(
                                  height: height / 10,
                                  width: width / 5,
                                  child: Image.asset(
                                    'assets/noteJournal.png',
                                  ),
                                ),
                              ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ),
              ],
            )),
      ),
    );
  }

  void displayBottomSheet(
      BuildContext context, BlockWriteJpournalPage provider) {
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
                        InkWell(
                          splashColor: Colors.white,
                          highlightColor: Colors.white,
                          onTap: () {
                            provider.onImageButtonPressed(ImageSource.camera,
                                context: context);
                            Navigator.of(context).pop();
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
                        InkWell(
                          splashColor: Colors.white,
                          highlightColor: Colors.white,
                          onTap: () {
                            provider.onImageButtonPressed(ImageSource.gallery,
                                context: context);
                            Navigator.of(context).pop();
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

  String recordFilePath;

  Future<bool> checkPermission() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  void startRecord() async {
    bool hasPermission = await checkPermission();
    if (hasPermission) {
      statusText = "Recording...";
      recordFilePath = await getFilePath();
      isComplete = false;
      RecordMp3.instance.start(recordFilePath, (type) {
        statusText = "Record error--->$type";
        setState(() {});
      });
    } else {
      statusText = "No microphone permission";
    }
    setState(() {});
  }

  void pauseRecord() {
    if (RecordMp3.instance.status == RecordStatus.PAUSE) {
      bool s = RecordMp3.instance.resume();
      if (s) {
        statusText = "Recording...";
        setState(() {});
      }
    } else {
      bool s = RecordMp3.instance.pause();
      if (s) {
        statusText = "Recording pause...";
        setState(() {});
      }
    }
  }

  io.File file;

  void stopRecord(BlockWriteJpournalPage provider) {
    bool s = RecordMp3.instance.stop();
    if (s) {
      statusText = "Record complete";
      isComplete = true;
      getFile()
          .then((value) async => {
                file = io.File(recordFilePath),
              })
          .then((value) => {provider.setAudiofile(file)});
    }
  }

  void resumeRecord() {
    bool s = RecordMp3.instance.resume();
    if (s) {
      statusText = "Recording...";
      setState(() {});
    }
  }

  int i = 0;

  Future<String> getFilePath() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath = storageDirectory.path + "/record";
    var d = Directory(sdPath);
    d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    return sdPath + "/test_${i++}.mp3";
  }

  Future<File> getFile() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath = storageDirectory.path + "/record";
    var d = Directory(sdPath);
    d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    return File(sdPath + "/test_${i++}.mp3");
  }

  openDailog({url}) {
    print('url is =$url');
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              child: Container(
                height: height / 10,
                width: width,
                child: AudioPlayerClass(
                  url: url,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

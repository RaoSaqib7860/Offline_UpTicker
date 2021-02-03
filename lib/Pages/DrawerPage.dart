import 'dart:io';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:upticker/ApiConfig/APiUtil.dart';
import 'package:upticker/ColorsThems/ThemesColors.dart';
import 'package:upticker/Pages/AccountSettings.dart';
import 'package:upticker/Pages/FeedBack.dart';
import 'package:upticker/Pages/JournalPage.dart';
import 'package:upticker/Pages/SingleTaskEdition.dart';
import 'package:upticker/Provider/BlockDrawerPage.dart';
import 'package:upticker/Provider/BlockFeedBack.dart';
import 'package:upticker/Provider/BlockJournel.dart';
import 'package:upticker/Provider/BlockSinglePageEdition.dart';
import 'package:upticker/Provider/GraphProvider.dart';
import 'Graph.dart';

class DrawerPage extends StatefulWidget {
  DrawerPage({Key key}) : super(key: key);

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  bool anim = false;
  bool anim1 = false;

  @override
  void initState() {
    print('Image path is =${ApiUtils.userImage}');
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        anim = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final BlockDrawerPage _provider = Provider.of<BlockDrawerPage>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              height: height,
              width: width,
              child: Column(
                children: [
                  SizedBox(
                    height: height / 10,
                  ),
                  _provider.imageFile == null
                      ? CircularProfileAvatar(
                          '${ApiUtils.userImage}',
                          elevation: 8,
                          radius: height / 11,
                        )
                      : CircularProfileAvatar(
                          '',
                          child: Image.file(
                            File(_provider.imageFile.path),
                            fit: BoxFit.cover,
                          ),
                          elevation: 8,
                          radius: height / 11,
                        ),
                  _provider.imageFile != null
                      ? Column(
                          children: [
                            SizedBox(
                              height: height / 50,
                            ),
                            InkWell(
                              onTap: () {
                                ApiUtils.updateProfileImage(
                                    provider: _provider);
                              },
                              child: Container(
                                height: 22,
                                width: width / 8,
                                child: Center(
                                  child: Text(
                                    'Save',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    color: ColorsThemes.mailColors,
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                            )
                          ],
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                        )
                      : Container(),
                  SizedBox(
                    height: height / 50,
                  ),
                  SizedBox(
                    height: height / 100,
                  ),
                  Text(
                    '${ApiUtils.fistName} ${ApiUtils.lastName}',
                    style:
                        TextStyle(color: ColorsThemes.mailColors, fontSize: 12),
                  ),
                  SizedBox(
                    height: height / 25,
                  ),
                  InkWell(
                      onTap: () {
                        // Navigator.of(context).pop();
                        Future.delayed(Duration(milliseconds: 50), () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  duration: Duration(milliseconds: 500),
                                  type: PageTransitionType.rightToLeft,
                                  child: ChangeNotifierProvider(
                                    create: (_) => BlockJournal(),
                                    child: JournalPage(),
                                  )));
                        });
                      },
                      child: rowdata(icon: Icons.home, text: 'Journal')),
                  SizedBox(
                    height: height / 30,
                  ),
                  InkWell(
                    child: rowdata(icon: Icons.collections, text: 'Data'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) => ChangeNotifierProvider(
                                create: (_) => GraphProvider(), child: Graph()),
                          ));
                    },
                  ),
                  SizedBox(
                    height: height / 30,
                  ),
                  InkWell(
                    child: rowdata(icon: Icons.edit, text: 'Edit Tasks'),
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                            duration: Duration(milliseconds: 500),
                            type: PageTransitionType.rightToLeft,
                            child: ChangeNotifierProvider(
                                create: (_) => BlockSinglePageEdition(),
                                child: SingleTaskEdition()),
                          ));
                    },
                  ),
                  SizedBox(
                    height: height / 30,
                  ),
                  InkWell(
                    child: rowdata(icon: Icons.open_in_browser, text: 'Share'),
                    onTap: () {
                      onShare(context);
                    },
                  ),
                  SizedBox(
                    height: height / 30,
                  ),
                  InkWell(
                      onTap: () {
                        // Navigator.of(context).pop();
                        Future.delayed(Duration(milliseconds: 300), () {
                          Navigator.push(
                              context,
                              PageTransition(
                                duration: Duration(milliseconds: 500),
                                type: PageTransitionType.rightToLeft,
                                child: ChangeNotifierProvider(
                                    create: (_) => BlockFeedBack(),
                                    child: FeedBackPage()),
                              ));
                        });
                      },
                      child:
                          rowdata(icon: Icons.feedback, text: 'Give Feedback')),
                  SizedBox(
                    height: height / 30,
                  ),
                  InkWell(
                    child: rowdata(icon: Icons.settings, text: 'Settings'),
                    onTap: () {
                      //Navigator.of(context).pop();
                      Future.delayed(Duration(milliseconds: 300), () {
                        Navigator.push(
                            context,
                            PageTransition(
                              duration: Duration(milliseconds: 500),
                              type: PageTransitionType.rightToLeft,
                              child: AccountSettingsPage(),
                            ));
                      });
                    },
                  ),
                  SizedBox(
                    height: height / 11,
                  ),
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 500),
                    opacity: anim1 == false ? 0 : 1,
                    child: AnimatedContainer(
                      height: height / 16,
                      width: width,
                      curve: Curves.easeIn,
                      margin: EdgeInsets.only(
                          left: anim1 == false ? width / 2 : width / 20,
                          right: anim1 == false ? width / 2 : width / 20),
                      child: Center(
                        child: Text(
                          'UpTicker',
                          style: TextStyle(
                              letterSpacing: 1,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: ColorsThemes.mailColors,
                          borderRadius: BorderRadius.circular(8)),
                      duration: Duration(milliseconds: 500),
                    ),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(
                  top: height / 10,
                ),
                padding: EdgeInsets.only(left: width / 4),
                child: InkWell(
                  onTap: () {
                    displayBottomSheet(context, _provider);
                  },
                  child: Icon(
                    Icons.edit,
                    color: Colors.blueGrey[300],
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Widget rowdata({IconData icon, String text}) {
    var width = MediaQuery.of(context).size.width;
    return AnimatedOpacity(
      duration: Duration(milliseconds: 300),
      opacity: anim == false ? 0 : 1,
      child: AnimatedContainer(
        curve: Curves.bounceOut,
        onEnd: () {
          setState(() {
            anim1 = true;
          });
        },
        padding: EdgeInsets.only(
            left: anim == false ? width / 5 : width / 20, right: width / 20),
        duration: Duration(milliseconds: 800),
        child: Row(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: ColorsThemes.mailColors,
                ),
                SizedBox(
                  width: width / 30,
                ),
                Text(
                  '$text',
                  style: TextStyle(
                      color: ColorsThemes.lightBlackColor, fontSize: 14),
                ),
              ],
            ),
            Icon(
              Icons.keyboard_arrow_right,
              color: ColorsThemes.mailColors,
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ),
    );
  }

  onShare(BuildContext context) async {
    final RenderBox box = context.findRenderObject();
    await Share.share(
        Platform.isIOS
            ? 'I’m UpTicker and it’s immensely useful. Click on the link to download the app for free! => https://apps.apple.com/gb/app/upticker/id1542230794'
            : 'I’m UpTicker and it’s immensely useful. Click on the link to download the app for free! => https://play.google.com/store/apps/details?id=com.epochs.upticker',
        subject: 'UpTicker',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  void displayBottomSheet(BuildContext context, BlockDrawerPage provider) {
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
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            provider.onImageButtonPressed(ImageSource.camera,
                                context: context);
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
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            provider.onImageButtonPressed(ImageSource.gallery,
                                context: context);
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
}

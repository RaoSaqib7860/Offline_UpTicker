import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:upticker/ApiConfig/APiUtil.dart';
import 'package:upticker/ColorsThems/ThemesColors.dart';
import 'package:upticker/Pages/FinalHomePage.dart';
import 'package:upticker/Provider/BlockFinalHomePage.dart';
import 'package:upticker/main.dart';
import 'OverlaySupport.dart';

class PushNotificationServices {
  static bool isnotify;
  showSuccessDailog(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: SingleChildScrollView(
                child: FadeIn(
                  child: Container(
                    decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    width: width,
                    padding: EdgeInsets.all(width / 20),
                    child: Column(
                      children: [
                        SizedBox(
                          height: height / 80,
                        ),
                        Text(
                          'Thank you very much for providing feedback. We take action to quickly resolve your issues. We will be in touch shortly with an update.',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: height / 30,
                        ),
                        Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                PageTransition(
                                    duration: Duration(milliseconds: 800),
                                    type: PageTransitionType.rightToLeft,
                                    child: ChangeNotifierProvider(
                                      create: (_) => BlockFinalHomePage(),
                                      child: FinalHomePageClass(),
                                    )),
                                ModalRoute.withName('/'),
                              );
                            },
                            child: Container(
                              height: height / 25,
                              width: width / 4,
                              child: Center(
                                child: Text(
                                  'Ok',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: ColorsThemes.mailColors,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          );
        });
  }
}

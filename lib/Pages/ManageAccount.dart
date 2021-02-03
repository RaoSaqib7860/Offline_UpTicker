import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upticker/ColorsThems/ThemesColors.dart';
import 'package:upticker/Provider/BlockManageAccount.dart';

class ManageAccount extends StatefulWidget {
  @override
  _ManageAccountState createState() => _ManageAccountState();
}

class _ManageAccountState extends State<ManageAccount> {
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<BlockMangeAccount>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar:  PreferredSize(
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
                            'Manage Account',
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
        body: Container(
          height: height,
          width: width,
          padding: EdgeInsets.only(
              left: width / 15, right: width / 15, top: height / 20),
          child: Column(
            children: [
              Text(
                '1.  Account log in',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(
                height: height / 50,
              ),
              Text(
                '2.  Del Account',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(
                height: height / 50,
              ),
              Text(
                '3.  Email',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(
                height: height / 50,
              ),
              Text(
                '4.  Password',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  letterSpacing: 0.5,
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ),
      ),
    );
  }
}

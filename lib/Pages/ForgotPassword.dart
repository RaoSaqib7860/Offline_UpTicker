import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upticker/ApiConfig/APiUtil.dart';
import 'package:upticker/ColorsThems/ThemesColors.dart';
import 'package:upticker/LocalWidget/LocalWidget.dart';
import 'package:upticker/Provider/BlockForgetPassword.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    final BlockForgotPassword _provider =
        Provider.of<BlockForgotPassword>(context);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        key: _provider.scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        body: Container(
          height: height,
          width: width,
          padding: EdgeInsets.only(left: width / 10, right: width / 10),
          child: Column(
              children: <Widget>[
                SizedBox(
                  height: height / 15,
                ),
                Text(
                  'Forgot Password',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: height / 20,
                ),
                _provider.verifyEmail == true
                    ? Column(
                        children: <Widget>[
                          Container(
                            width: width,
                            height: height / 15,
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 5,
                                      spreadRadius: 2.0,
                                      offset: Offset(
                                        3.0,
                                        5.0,
                                      ),
                                    ),
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: TextFormField(
                                controller: _provider.passwordCon,
                                style: TextStyle(
                                    color: ColorsThemes.orangeColors,
                                    fontSize: 14),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      size: 16,
                                      color: ColorsThemes.orangeColors,
                                    ),
                                    contentPadding: EdgeInsets.all(width / 40),
                                    labelText: 'Password',
                                    labelStyle: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height / 30,
                          ),
                          Container(
                            width: width,
                            height: height / 15,
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 5,
                                      spreadRadius: 2.0,
                                      offset: Offset(
                                        3.0,
                                        5.0,
                                      ),
                                    ),
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: TextFormField(
                                controller: _provider.otpCon,
                                style: TextStyle(
                                    color: ColorsThemes.orangeColors,
                                    fontSize: 14),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                      Icons.lock_outline,
                                      size: 16,
                                      color: ColorsThemes.orangeColors,
                                    ),
                                    contentPadding: EdgeInsets.all(width / 40),
                                    labelText: 'Enter OTP',
                                    labelStyle: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ),
                          )
                        ],
                      )
                    : Container(
                        width: width,
                        height: height / 15,
                        child: Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5,
                                  spreadRadius: 2.0,
                                  offset: Offset(
                                    3.0,
                                    5.0,
                                  ),
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: TextFormField(
                            controller: _provider.emailCon,
                            style: TextStyle(
                                color: ColorsThemes.orangeColors, fontSize: 14),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.mail,
                                  size: 16,
                                  color: ColorsThemes.orangeColors,
                                ),
                                contentPadding: EdgeInsets.all(width / 40),
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black38,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                SizedBox(
                  height: height / 20,
                ),
                InkWell(
                  onTap: () {
                    if (_provider.verifyEmail == false) {
                      if (_provider.emailCon.text.isNotEmpty) {
                        ApiUtils.getResendCodeForResetPasswordCalling(
                            context: context,
                            email: _provider.emailCon.text,
                            provider: _provider,
                            scaffoldkey: _provider.scaffoldKey);
                      }
                    } else {
                      if (_provider.passwordCon.text.isNotEmpty &&
                          _provider.otpCon.text.isNotEmpty) {
                        ApiUtils.getCreateNewPasswordCalling(
                            context: context,
                            otp: _provider.otpCon.text,
                            password: _provider.passwordCon.text,
                            scaffoldkey: _provider.scaffoldKey);
                      }
                    }
                  },
                  child: Container(
                    width: width,
                    height: height / 13,
                    child: Center(
                      child: Text(
                        'Next',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            letterSpacing: 0.5),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: ColorsThemes.loginColors,
                        borderRadius: BorderRadius.circular(7)),
                    margin:
                        EdgeInsets.only(left: width / 10, right: width / 10),
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center),
        ),
      ),
    );
  }
}

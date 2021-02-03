import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlockForgotPassword extends ChangeNotifier {
  TextEditingController _emailNameCon=TextEditingController();
  TextEditingController get emailCon=>_emailNameCon;

  TextEditingController _passwordNameCon=TextEditingController();
  TextEditingController get passwordCon=>_passwordNameCon;

  TextEditingController _otpcont=TextEditingController();
  TextEditingController get otpCon=>_otpcont;
  GlobalKey<ScaffoldState> _scaffoldKey= GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey=>_scaffoldKey;
  
  bool _verifyEmail=false;
  bool get verifyEmail=>_verifyEmail;

  setVerifyEmail(String change){
    if (change=='do') {
       _verifyEmail=true;
    }else{
       _verifyEmail=false;
    }
    notifyListeners();
  }
}
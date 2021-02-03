import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlockLogin extends ChangeNotifier {
  TextEditingController _emailNameCon = TextEditingController();
  TextEditingController get emailCon => _emailNameCon;

  TextEditingController _passwordNameCon = TextEditingController();
  TextEditingController get passwordCon => _passwordNameCon;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  bool _loading = false;
  bool get loading => _loading;

  String _gmailtoken = '';
  String get userGmailToken => _gmailtoken;

  bool _loginForgmail = false;
  bool get loginForgmail => _loginForgmail;

  setGmailLoginSucces(bool value) {
    _loginForgmail = value;
    notifyListeners();
  }

  bool _loginForfb = false;
  bool get loginForfb => _loginForfb;

  setFBLoginSucces(bool value) {
    _loginForfb = value;
    notifyListeners();
  }

  setGmailToken(String token) {
    _gmailtoken = token;
  }

  setLoding(bool value) {
    _loading = value;
    notifyListeners();
  }

  String _fbToken;
  String get fbToken => _fbToken;

  setfbToken(String token) {
    _fbToken = token;
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlockSignUp extends ChangeNotifier {
  TextEditingController _firstNameCon = TextEditingController();
  TextEditingController get firstNameCon => _firstNameCon;

  TextEditingController _lastNameCon = TextEditingController();
  TextEditingController get lastNameCon => _lastNameCon;

  TextEditingController _emailNameCon = TextEditingController();
  TextEditingController get emailCon => _emailNameCon;

  TextEditingController _passwordNameCon = TextEditingController();
  TextEditingController get passwordCon => _passwordNameCon;

  TextEditingController _repasswordCon = TextEditingController();
  TextEditingController get repasswordCon => _repasswordCon;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  List _reponceListList = [];
  List get controllerList => _reponceListList;

  bool _loading = false;
  bool get loading => _loading;

  setLoding(String value) {
    if (value == 'do') {
      _loading = true;
    } else {
      _loading = false;
    }
    notifyListeners();
  }

  String _fbToken;
  String get fbToken => _fbToken;

  setfbToken(String token) {
    _fbToken = token;
    notifyListeners();
  }

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

  String _gmailtoken = '';
  String get userGmailToken => _gmailtoken;
  setGmailToken(String token) {
    _gmailtoken = token;
    notifyListeners();
  }

  String _gmailrefreshtoken = '';
  String get gmailrefreshtoken => _gmailrefreshtoken;
  setgmailrefreshtoken(String token) {
    _gmailrefreshtoken = token;
  }
}

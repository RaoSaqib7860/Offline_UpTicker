import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlockExcercise1 extends ChangeNotifier {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  String _id = '';
  String get id => _id;
  setId(String ids) {
    _id = ids;
  }
}

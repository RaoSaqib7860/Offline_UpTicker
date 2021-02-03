import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlockCreateSubCustomBucketTask extends ChangeNotifier {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  List _customsubBucketData = [];
  List get customBucketData => _customsubBucketData;
  setCustomSubBucketData(List data) {
    _customsubBucketData = data;
  }

  bool _loading = false;
  bool get loading => _loading;
  setLoading() {
    _loading = true;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BlockAditionalMentorTask extends ChangeNotifier {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  List _customsubBucketData = [];
  List get customBucketData => _customsubBucketData;
  setCustomSubBucketData(List data) {
    _customsubBucketData = data;
  }

  List _addsubbucketList = [];
  List get subbucketList => _addsubbucketList;
  setaddsubbucketList(String id) {
    _addsubbucketList.add(int.parse(id));
  }

  bool _loading = false;
  bool get loading => _loading;
  setLoading() {
    _loading = true;
    notifyListeners();
  }

  bool _loadingaddtask = false;
  bool get loadingaddtask => _loadingaddtask;
  setloadingaddtask(bool v) {
    _loadingaddtask = v;
    notifyListeners();
  }
}

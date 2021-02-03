import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlockCreateCustomTaskBucket extends ChangeNotifier{
   GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  List _customBucketData=[];
  List get customBucketData=>_customBucketData;
  setCustomBucketData(List data){
   _customBucketData=data;

  }

  bool _loading = false;
  bool get loading => _loading;
  setLoading() {
    _loading = true;
    notifyListeners();
  }


}
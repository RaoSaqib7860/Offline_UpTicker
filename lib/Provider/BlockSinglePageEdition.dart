import 'package:flutter/material.dart';

class BlockSinglePageEdition extends ChangeNotifier{
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool v){
    _loading=v;
    notifyListeners();
  }

  List _listofTask=[];
  List get listoftask=>_listofTask;
  setListOfTask(List list){
    _listofTask=list;
    notifyListeners();
  }

}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlockNotificationSound extends ChangeNotifier {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  List _listofsound = [
    'Default',
    'acoustic',
    'aintgottimern',
    'airhorna',
    'airhornb',
    'airhornshort',
    'alert',
    'applausehugethunderous',
    'beepa',
    'beepb',
    'cashregisterpurchase',
    'cheer',
    'gettowork',
    'ineedtomakesomemoney',
    'nuclearalarm',
    'peoplecheerandclap',
    'retro'
  ];
  List get listofsound => _listofsound;

  List _lisofChecks=<bool>[
  ];
  List get lisofChecks=>_lisofChecks;
  setListOFChecks(String tag){
    for(var i=0;i<_listofsound.length;i++){
      if(tag==_listofsound[i]){
        _lisofChecks.add(true);
      }else{
        _lisofChecks.add(false);
      }
    }
  }

}

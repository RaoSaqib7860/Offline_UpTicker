import 'package:upticker/Pages/FinalHomePage.dart';
import 'package:upticker/Provider/BlockFinalHomePage.dart';

class RedoService {
  Map mapdata;
  String date;
  BlockFinalHomePage provider;
  RedoService({this.mapdata, this.date, this.provider});

  void checkRecord() {
    if (FinalHomePageClass.listofDateR.length > 0) {
      print('Redo Date is here');
      if (FinalHomePageClass.listofDateR.contains(date)) {
        print('Redo is contain');
        int index = FinalHomePageClass.listofDateR.indexOf(date);
        List l = FinalHomePageClass.finallistR[index];
        if (l.length > 0) {
          print('Redo is enable');
          provider.setisredo(true);
        }
      }
    }
  }

  void addData() {
    print('welcome');
    if (FinalHomePageClass.listofDateR.length > 0) {
      print('has');
      if (FinalHomePageClass.listofDateR.contains(date)) {
        int index = FinalHomePageClass.listofDateR.indexOf(date);
        FinalHomePageClass.finallistR[index].add(mapdata);
        print('Redo list of date = ${FinalHomePageClass.listofDateR}');
        print('Redo list of dictionary = ${FinalHomePageClass.finallistR}');
      } else {
        FinalHomePageClass.listofDateR.add(date);
        List data = [mapdata];
        FinalHomePageClass.finallistR.add(data);
        print('Redo not containe');
        print('Redo list of date = ${FinalHomePageClass.listofDateR}');
        print('Redo list of dictionary = ${FinalHomePageClass.finallistR}');
      }
    } else {
      print('Redo has not');
      FinalHomePageClass.listofDateR.add(date);
      List data = [mapdata];
      FinalHomePageClass.finallistR.add(data);
      print('Redo list of date = ${FinalHomePageClass.listofDateR}');
      print('Redo list of dictionary = ${FinalHomePageClass.finallistR}');
    }
    Future.delayed(Duration(milliseconds: 300), () {
      provider.setisredo(true);
      FinalHomePageClass.pendingR = true;
    });
  }

  void getData() {
    if (FinalHomePageClass.listofDateR.length > 0) {
      if (FinalHomePageClass.listofDateR.contains(date)) {
        int index = FinalHomePageClass.listofDateR.indexOf(date);
        List l = FinalHomePageClass.finallistR[index];
        if (l.length > 0) {
          FinalHomePageClass.undorecordR = l.last;
          print('Redo last recod is = ${l.last}');
          FinalHomePageClass.finallistR[index].removeLast();
          if (FinalHomePageClass.finallistR[index].length < 1) {
            provider.setisredo(false);
          }
        } else {
          FinalHomePageClass.pendingR = false;
          print('no record found');
        }
      }
    } else {
      print('no record found .');
    }
  }
}

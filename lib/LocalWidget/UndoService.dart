import 'package:upticker/Pages/FinalHomePage.dart';
import 'package:upticker/Provider/BlockFinalHomePage.dart';

class UndoService {
  Map mapdata;
  String date;
  BlockFinalHomePage provider;
  UndoService({this.mapdata, this.date, this.provider});

  void checkRecord() {
    if (FinalHomePageClass.listofDate.length > 0) {
      print('Undo Date is here');
      if (FinalHomePageClass.listofDate.contains(date)) {
        print('Undo Date Contain');
        int index = FinalHomePageClass.listofDate.indexOf(date);
        List l = FinalHomePageClass.finallist[index];
        if (l.length > 0) {
          print('Undo is enable');
          provider.setisundo(true);
        }
      }
    }
  }

  void addData() {
    print('welcome');
    if (FinalHomePageClass.listofDate.length > 0) {
      print('has');
      if (FinalHomePageClass.listofDate.contains(date)) {
        int index = FinalHomePageClass.listofDate.indexOf(date);
        FinalHomePageClass.finallist[index].add(mapdata);
        print('list of date = ${FinalHomePageClass.listofDate}');
        print('list of dictionary = ${FinalHomePageClass.finallist}');
      } else {
        FinalHomePageClass.listofDate.add(date);
        List data = [mapdata];
        FinalHomePageClass.finallist.add(data);
        print('not containe');
        print('list of date = ${FinalHomePageClass.listofDate}');
        print('list of dictionary = ${FinalHomePageClass.finallist}');
      }
    } else {
      print('has not');
      FinalHomePageClass.listofDate.add(date);
      List data = [mapdata];
      FinalHomePageClass.finallist.add(data);
      print('list of date = ${FinalHomePageClass.listofDate}');
      print('list of dictionary = ${FinalHomePageClass.finallist}');
    }
    Future.delayed(Duration(milliseconds: 300), () {
      provider.setisundo(true);
      FinalHomePageClass.pending = true;
    });
  }

  void getData() {
    if (FinalHomePageClass.listofDate.length > 0) {
      if (FinalHomePageClass.listofDate.contains(date)) {
        int index = FinalHomePageClass.listofDate.indexOf(date);
        List l = FinalHomePageClass.finallist[index];
        if (l.length > 0) {
          FinalHomePageClass.undorecord = l.last;
          print(' last recod is = ${l.last}');
          FinalHomePageClass.finallist[index].removeLast();
          if (FinalHomePageClass.finallist[index].length < 1) {
            provider.setisundo(false);
          }
        } else {
          FinalHomePageClass.pending = false;
          print('Undo length is less than than 0');
        }
      }
    } else {
      print('no record found .');
    }
  }
}

import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:upticker/DBModels/FinalHomePageDataModel.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider instance = DBProvider._();
  static Database _database;

  get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initClientDB();
    // _database = await initSaveLoginDB();
    return _database;
  }


  // Final home page Work start ////////////////////////////////////////////////////////////
  initClientDB() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'TestDB.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(FinalHomePageDataModel.CREATE_TABLE_FINAL_HOME_PAGE);
    });
  }

  insertfinalHomePageData(FinalHomePageDataModel finalhomepage) async {
    final dbLogin = await database;
    var count = Sqflite.firstIntValue(await dbLogin.rawQuery(
        "SELECT COUNT(*) FROM ${FinalHomePageDataModel.FINAL_HOME_Table} WHERE id = ?",
        [finalhomepage.id]));
    var res;
    if (count == 0) {
      res = await dbLogin.insert(
          FinalHomePageDataModel.FINAL_HOME_Table, finalhomepage.toJson());
    } else {
      await dbLogin.update(
          FinalHomePageDataModel.FINAL_HOME_Table, finalhomepage.toJson(),
          where: "id = ?", whereArgs: [finalhomepage.id]);
    }
    return res;
  }

  Future<List<Map>> getAllfinalHomePageDataRecord() async {
    final db = await database;
    List<Map> list = await db.query(FinalHomePageDataModel.FINAL_HOME_Table);
    return list;
  }

  deletefinalHomePageDataData(int id) async {
    final db = await database;
    db.delete(FinalHomePageDataModel.FINAL_HOME_Table,
        where: "id = ?", whereArgs: [id]);
  }
  deleteALLfinalHomePageDataData() async {
    final db = await database;
    db.delete(FinalHomePageDataModel.FINAL_HOME_Table);
  }
  // Final home page Work end ////////////////////////////////////////////////////////////
}

import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:rogella_radio/models/myradio.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelperTwo {
  static DatabaseHelperTwo _databaseHelper;
  static Database _database;

  String _databaseName = "crudb.db";
  String _favoriteTableName = "favorites";
  String _reportTableName = "reports";

  factory DatabaseHelperTwo() {
    if (_databaseHelper == null) {
      _databaseHelper = new DatabaseHelperTwo._internal();
      return _databaseHelper;
    }
    return _databaseHelper;
  }

  DatabaseHelperTwo._internal();

  Future<Database> _getDatabase() async {
    if (_database == null) {
      _database = await _initializeDatabase();
      return _database;
    }
    return _database;
  }

  Future<Database> _initializeDatabase() async {
    Directory dizin = await getApplicationDocumentsDirectory();
    String dbPath = join(dizin.path, _databaseName);

    //tablo yoksa tabloyu oluşturur.
    //eğer tabloda bir değişiklik yapılırsa version değeri değiştirilmelidir.
    Database crudDB = await openDatabase(dbPath,
        version: 1, onCreate: _createDB, onUpgrade: _onUpgrade);
    return crudDB;
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute(
        "CREATE TABLE favorites (id	INTEGER PRIMARY KEY AUTOINCREMENT,stationuuid	TEXT,name TEXT,url TEXT,url_resolved TEXT,homepage TEXT,favicon TEXT,tags TEXT,country TEXT,countrycode TEXT,state TEXT,language TEXT,votes TEXT,codec TEXT)");
    await db.execute(
        "CREATE TABLE $_reportTableName (id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "radio_id INTEGER,"
        "stationuuid TEXT)");
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {}
  }

  Future<List<Map<String, dynamic>>> allFavorites() async {
    Database db = await _getDatabase();
    List<Map<String, dynamic>> sonuc = await db.query(_favoriteTableName);

    return sonuc;
  }

  Future<int> favoriteControl(MyRadio myRadio) async {
    Database db = await _getDatabase();
    var sonuc = await db
        .query(_favoriteTableName, where: "id = ?", whereArgs: [myRadio.id]);
    return sonuc.length;
  }

  Future<String> favoriteAddAndDelete(MyRadio myRadio) async {
    Database db = await _getDatabase();
    var sonuc = await db
        .query(_favoriteTableName, where: "id = ?", whereArgs: [myRadio.id]);
    if (sonuc.length == 0) {
      await favoriteAdd(myRadio);
      return "add";
    } else {
      await favoriteDelete(myRadio.id);
      return "delete";
    }
  }

  Future<int> favoriteAdd(MyRadio myRadio) async {
    Database db = await _getDatabase();

    int sonuc = await db.insert(_favoriteTableName, myRadio.toMap(),
        nullColumnHack: null);
    return sonuc;
  }

  Future<int> favoriteDelete(int id) async {
    Database db = await _getDatabase();
    int result = await db
        .rawDelete("DELETE FROM $_favoriteTableName WHERE id = ?", [id]);
    return result;
  }
}

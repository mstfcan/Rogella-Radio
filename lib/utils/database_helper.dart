import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = new DatabaseHelper._internal();
      return _databaseHelper;
    }
    return _databaseHelper;
  }

  DatabaseHelper._internal();

  Future<Database> _getDatabase() async {
    if (_database == null) {
      _database = await _initializeDatabase();
      return _database;
    }
    return _database;
  }

  Future<Database> _initializeDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "radioapi.db");

    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      ByteData data = await rootBundle.load(join('assets/db', 'radioapi.db'));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await new File(path).writeAsBytes(bytes);
    }

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String databasePath = join(appDocDir.path, 'radioapi.db');
    Database radioDB = await openDatabase(databasePath);

    return radioDB;
  }

  Future<List<Map<String, dynamic>>> allCategories() async {
    Database db = await _getDatabase();
    List<Map<String, dynamic>> sonuc = await db.query("category");

    return sonuc;
  }

  Future<List<Map<String, dynamic>>> allCountry(String orderColumn) async {
    Database db = await _getDatabase();
    List<Map<String, dynamic>> sonuc =
        await db.query("countries", orderBy: orderColumn);

    return sonuc;
  }

  Future<List<Map<String, dynamic>>> getRandomRadios() async {
    Database db = await _getDatabase();
    List<Map<String, dynamic>> sonuc = await db.query("radios",
        orderBy: "RANDOM()", limit: 10, distinct: true);

    return sonuc;
  }

  Future<List<Map<String, dynamic>>> getSearchRadios(String search) async {
    Database db = await _getDatabase();
    List<Map<String, dynamic>> sonuc = await db.query(
      "radios",
      orderBy: "votes",
      distinct: true,
      where: "name LIKE ?",
      whereArgs: ["%" + search.toLowerCase() + "%"],
    );

    return sonuc;
  }

  Future<List<Map<String, dynamic>>> getCountryRadios(
      String country_code) async {
    Database db = await _getDatabase();
    List<Map<String, dynamic>> sonuc = await db.query(
      "radios",
      orderBy: "votes",
      distinct: true,
      where: "countrycode = ?",
      whereArgs: [country_code],
    );

    return sonuc;
  }

  Future<List<Map<String, dynamic>>> getCategoryRadios(String category) async {
    Database db = await _getDatabase();
    List<Map<String, dynamic>> sonuc = await db.query(
      "radios",
      orderBy: "votes",
      distinct: true,
      where: "tags LIKE ?",
      whereArgs: ["%" + category.toLowerCase() + "%"],
    );

    return sonuc;
  }
}

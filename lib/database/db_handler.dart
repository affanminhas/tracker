import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

import 'package:tracker/model/tracker_data_model.dart';

class DBHelper {
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDataBase();
    return _database;
  }

  initDataBase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "tracker.db");
    var database = openDatabase(path, version: 1, onCreate: _onCreate);
    return database;
  }

  _onCreate(Database database, int version) async {
    await database.execute(
        "CREATE TABLE tracker (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, description TEXT NOT NULL, date TEXT NOT NULL, time TEXT NOT NULL, expense TEXT NOT NULL, amount TEXT NOT NULL)");
  }

  /// ---- Inserting items into database ----
  Future<TrackerDataModel> insert(TrackerDataModel trackerDataModel) async {
    var dbClient = await database;
    await dbClient!.insert("tracker", trackerDataModel.toMap());
    return trackerDataModel;
  }

  /// ---- Fetch data from database ----
  Future<List<TrackerDataModel>> getNotesList() async {
    var dbClient = await database;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query("tracker");

    return queryResult.map((e) => TrackerDataModel.fromMap(e)).toList();
  }

  /// ---- Fetch data from database ----
  Future<List<Map<String, Object?>>> getNotesListOnly() async {
    var dbClient = await database;
    final List<Map<String, Object?>> queryResult =
    await dbClient!.query("tracker");

    return queryResult;
  }

  Future<int> delete(int id)async{
    var dbClient = await database;
    return dbClient!.delete(
        "tracker",
        where: "id = ?",
        whereArgs: [id]
    );
  }
}

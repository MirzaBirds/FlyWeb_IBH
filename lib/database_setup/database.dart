import 'dart:async';

import 'package:doctor_dreams/database_setup/models/dataHistory.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {

    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "Report.db");

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE HeartData (id INTEGER PRIMARY KEY,date INTEGER,value TEXT)');
    });
  }

  /* planeCategories(PlaneCategories newClient) async {
    final db = await database;
    var raw = await db!.rawInsert(
        "INSERT Into PlaneCategories (id,name)"
            "VALUES (?,?)",
        [newClient.id, newClient.name]);
    return raw;
  }
*/
   otherDetails(DataHistory newClient) async {
    final db = await database;
    var raw = await db!.rawInsert(
        "INSERT Into OtherDetails (id,help,disclaimer,about)"
            "VALUES (?,?,?,?)",
        [
          newClient.id,
          newClient.date,
          newClient.value,
        ]);
    return raw;
  }

  /* newClient(QuestionDetails newClient) async {
    final db = await database;
    var raw = await db!.rawInsert(
        "INSERT Into Questions (system_id,question,answer,description)"
            "VALUES (?,?,?,?)",
        [
          newClient.systemId,
          newClient.question,
          newClient.answer,
          newClient.description
        ]);
    return raw;
  }*/

  /*newSystemList(SystemListModel newClient) async {
    final db = await database;
    var raw = await db!.rawInsert(
        "INSERT Into SystemList (plane_id,name,status)"
            "VALUES (?,?,?)",
        [newClient.planeId, newClient.name, newClient.status]);
    return raw;
  }*/

  updateClient(String q, String a, String d, int id) async {
    print("Question Id update ${id}");
    final db = await database;
    var res = await db!.update(
        "Questions", {"question": q, "answer": a, "description": d},
        where: "id = ?", whereArgs: [id]);
    return res;
  }

  /* updateSystemList(SystemListModel newClient) async {
    final db = await database;
    var res = await db!.update("SystemList", newClient.toJson(),
        where: "id = ?", whereArgs: [newClient.id]);
    return res;
  }*/

  Future<List<Map>> getAllSystemListMap() async {
    final db = await database;
    List<Map> list = (await db!.rawQuery('SELECT * FROM SystemList'));
    return list;
  }

  Future<List<Map>> getAllClientsMap() async {
    final db = await database;
    List<Map> list = (await db!.rawQuery('SELECT * FROM Questions'));
    return list;
  }

  deleteClient(int id) async {
    final db = await database;
    return db!.delete("Questions", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db!.rawDelete("Delete * from Questions");
  }

/*Future<List<QuestionDetails>> getAllQuestions(int id) async {
    final db = await database;
    var res =
    await db!.query("Questions", where: "system_id = ?", whereArgs: [id]);
    List<QuestionDetails> list = res.isNotEmpty
        ? res.map((c) => QuestionDetails.fromJson(c)).toList()
        : <QuestionDetails>[
      QuestionDetails(
        systemId: id,
        question: 'Please add a new question',
        answer: "Please add a new answer",
        description: "",
      ),
    ];
    return list;
  }

  Future<List<QuestionDetails>> getMultipleIds1(List<int> ids) async {
    final db = await database;
    var res =
    await db!.query("Questions", where: "system_id IN (${ids.join(",")})");
    List<QuestionDetails> list = res.isNotEmpty
        ? res.map((c) => QuestionDetails.fromJson(c)).toList()
        : [];
    return list;
  }

  Future<List<SystemListModel>> getAllSystemList(int planeId) async {
    final db = await database;
    var res = await db!
        .query("SystemList", where: "plane_id = ?", whereArgs: [planeId]);
    List<SystemListModel> list = res.isNotEmpty
        ? res.map((c) => SystemListModel.fromJson(c)).toList()
        : [];
    return list;
  }
*/
  Future<List<DataHistory>> getOtherDetails() async {
    final db = await database;
    var res = await db!.query("OtherDetails");
    List<DataHistory> list =
    res.isNotEmpty ? res.map((c) => DataHistory.fromJson(c)).toList() : [];
    return list;
  }

  /*Future<List<PlaneCategories>> getPlaneCategories() async {
    final db = await database;
    var res = await db!.query("PlaneCategories");
    List<PlaneCategories> list = res.isNotEmpty
        ? res.map((c) => PlaneCategories.fromJson(c)).toList()
        : [];
    return list;
  }*/
}

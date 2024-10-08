import 'package:kairos/models/event.dart';
import 'package:sqflite/sqflite.dart';



class DBHelper{
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = "events";


  static Future<void> initDb() async
  {
    if(_db !=null)
      {
        return;
      }
    try {
      String _path = await getDatabasesPath() + 'events.db';
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version){
          print("create a new one");
          return db.execute(
            "CREATE TABLE $_tableName("
                "id INTEGER PRIMARY KEY AUTOINCREMENT,"
                "title STRING, note TEXT, date STRING,"
                "starTime STRING, endTime STRING,"
                "remind INTEGER, repeat STRING,"
                "color INTEGER,"
                "isConpleted INTEGER)"
          );
        }
      );
    }catch(e)
    {
      print(e);
    }
  }

  static Future<int> insert(Event? event) async{
    print("insert called");
    return await _db?.insert(_tableName, event!.toJson())??1;
  }

  static Future<List<Map<String, dynamic>>> query() async{
    print("query called");
    return await _db!.query(_tableName);
  }

  static deleteEventDb(Event event) async{
    await _db!.delete(_tableName, where: 'id=?', whereArgs: [event.id]);

  }

  static updateEvent(int id) async{
    return await _db!.rawUpdate(
      '''
        UPDATE events
        SET isConpleted = ?
        WHERE id = ?
      ''', [1, id]);
  }
}
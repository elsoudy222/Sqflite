import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LiteDb {

  static Database? _db;

  Future<Database?> get getInstance async {
    if (_db == null) {
      _db = await instance();
      return _db;
    } else {
      return _db;
    }
  }

  instance() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'lite_sql.db');

    // open the database
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              '''  
                CREATE TABLE PERSON (id INTEGER  PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, age INTEGER);
                CREATE TABLE ACCOUNT (id INTEGER  PRIMARY KEY AUTOINCREMENT, PERSON_ID INTEGER NOT  NULL, ACCOUNT INTEGER NOT NULL, VALUE REAL);
              ''');
          print('***** Database has been created *****');
        });
    print('******* Database Connected *******');
    return database;
  }

  inquiry(String sqlTxt) async {
    Database? db = await getInstance;
    // Get the records
    List<Map> list = await db!.rawQuery(sqlTxt);
    return list;
  }

  insert(String sqlTxt) async {
    Database? db = await getInstance;
    // Insert some record
    int count = await db!.rawInsert(sqlTxt);
    return count;
  }

  update(String sqlTxt) async {
    Database? db = await getInstance;
    // Update some record
    int count = await db!.rawUpdate(sqlTxt);
    return count;
  }

  delete(String sqlTxt) async {
    Database? db = await getInstance;
    // Delete some record
    int count = await db!.rawDelete(sqlTxt);
    return count;
  }
}
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Mydb {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialdb();
      return _db;
    } else {
      return _db;
    }
  }

  initialdb() async {
    String databasepath = await getDatabasesPath();

    String path = join(databasepath, 'srour.db');
    Database mydb = await (openDatabase(path, onCreate: _oncreate, version: 1));
    return mydb;
  }

  _oncreate(Database db, int virsion) async {
    await db.execute('''
    CREATE TABLE "users" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL,
  "email" TEXT NOT NULL,
  "badget" INT NOT NULL,
  "balancebank" INT NOT NULL
);
  ''');
    await db.execute('''
  CREATE TABLE installments (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    monyflow TEXT NOT NULL,
    date TEXT NOT NULL,
    notes TEXT NOT NULL
  );
''');
  }

  // select data
  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  //insertdata
  insertdata(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  //delet data
  deletdata(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  // update data
  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  // delet all database
  myDeletDatabase() async {
    String databasepath = await getDatabasesPath();

    String path = join(databasepath, 'srour.db');
    print("all delet");
    return deleteDatabase(path);
  }
}

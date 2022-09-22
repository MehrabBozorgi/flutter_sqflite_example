import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static const product = 'product';

  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    return await openDatabase(
      join(dbPath, 'db_helper.db'),
      onCreate: (db, version) {
        db.execute('CREATE TABLE IF NOT EXISTS $product(id TEXT PRIMARY KEY ,'
            ' productName TEXT,'
            ' productPrice TEXT,'
            ' productImage TEXT)');
      },
      version: 1,
    );
  }

  // insert data
  static Future insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    return db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //show all items
  static Future<List<Map<String, dynamic>>> selectAll(
    String table,
    order,
  ) async {
    final db = await DBHelper.database();
    return db.query(
      table,
      orderBy: order,
    );
  }

  //delete value by id
  static Future<void> deleteById(
    String table,
    String columnId,
    String id,
  ) async {
    final db = await DBHelper.database();
    await db.delete(
      table,
      where: "$columnId = ?",
      whereArgs: [id],
    );
  }

  //delete table
  static Future deleteTable(String table) async {
    final db = await DBHelper.database();
    return db.rawDelete('DELETE FROM ${table}');
  }

  //show items by id
  static Future selectProductById(String id) async {
    final db = await DBHelper.database();
    return await db.rawQuery(
      "SELECT * from ${DBHelper.product} where id = ? ",
      [id],
    );
  }

  //show items
  static Future<List<Map<String, dynamic>>> selectProduct() async {
    final db = await DBHelper.database();
    var select = await db.query(DBHelper.product);
    return select;
  }
}

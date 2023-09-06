import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Item {
  int id;
  String name;
  String description;

  Item({required this.id, required this.name, required this.description});
}

class DatabaseHelper {
  static Database? _database;

  // Create and open the database.
  static Future<Database> _openDatabase() async {
    if (_database == null) {
      String dbPath = await getDatabasesPath();
      String path = join(dbPath, 'my_database.db');

      _database = await openDatabase(path, version: 1, onCreate: _onCreate);
    }
    return _database!;
  }

  // Create the database table.
  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE my_table (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        age INTEGER
      )
    ''');
  }

  // Insert data into the database.
  static Future<int> insertData(String name, String age) async {
    Database db = await _openDatabase();
    Map<String, dynamic> row = {
      'name': name,
      'age': age,
    };
    return await db.insert('my_table', row);
  }

  Future<void> deleteItem(int id) async {
    Database db = await _openDatabase();
    await db.delete('my_table', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Item>> getItems() async {
    Database db = await _openDatabase();
    List<Map<String, dynamic>> items = await db.query('my_table');
    return items
        .map((item) =>
            Item(id: item['id'], name: item['name'], description: item['age']))
        .toList();
  }

  // Query all data from the database.
  static Future<List<Map<String, dynamic>>> queryAllData() async {
    Database db = await _openDatabase();
    return await db.query('my_table');
  }
}

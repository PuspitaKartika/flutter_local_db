import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/task_model.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static late Database _database;

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  // Membuat objek database
  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  //membuat koneksi database dan membuat tabel
  final String _tabelName = 'tasks';

  Future<Database> _initializeDb() async {
    var db = openDatabase(join(await getDatabasesPath(), 'task_db.db'),
        onCreate: (db, version) async {
      await db.execute(
        '''CREATE TABLE $_tabelName(
            id INTEGER PRIMARY KEY,
            taskName TEXT
          )''',
      );
    }, version: 1);
    return db;
  }

  //menambahkan data ke tabel
  Future<void> insertTask(TaskModel taskModel) async {
    final Database db = await database;
    await db.insert(_tabelName, taskModel.toMap());
  }

  //membuat method untuk membaca data
  Future<List<TaskModel>> getTasks() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(_tabelName);
    return results.map((e) => TaskModel.fromMap(e)).toList();
  }

  // Membuat method untuk mengambil data dengan id
  Future<TaskModel> getTaskById(int id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      _tabelName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return results.map((e) => TaskModel.fromMap(e)).first;
  }

  // membuat method untuk memperbarui data
  Future<void> updateTask(TaskModel taskModel) async {
    final db = await database;
    await db.update(_tabelName, taskModel.toMap(),
        where: 'id = ?', whereArgs: [taskModel.id]);
  }

  // membuat method untuk menghapus data
  Future<void> deleteTask(int id) async {
    final db = await database;
    await db.delete(_tabelName, where: 'id = ?', whereArgs: [id]);
  }
}

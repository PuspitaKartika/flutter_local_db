import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
}

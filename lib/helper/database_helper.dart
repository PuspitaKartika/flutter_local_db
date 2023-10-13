class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();
}

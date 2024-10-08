part of 'database.dart';

class DatabaseService {
  Database? _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initialize;
    return _database!;
  }

  Future<String> get fullPath async {
    const name = "nota.db";
    final path = await getDatabasesPath();
    return join(path, name);
  }

  Future<Database> get _initialize async {
    final path = await fullPath;
    var database = await openDatabase(path,
        version: 1, onCreate: create, singleInstance: true);
    return database;
  }

  Future<void> create(Database database, int version) async {
    await ProductDB().createTable(database);
    await CompanyDB().createTable(database);
    await TransactionDB().createTable(database);
  }
}

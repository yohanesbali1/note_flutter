part of 'database.dart';

class ProductDB {
  final tablename = 'product';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tablename(
      "id" INTEGER NOT NULL,
      "name" VARCHAR(99) NOT NULL,
      "created_at" INTEGER NOT NULL DEFAULT (cast(strftime('%s', 'now') as INTEGER)),
      "updated_at" INTEGER NOT NULL DEFAULT (cast(strftime('%s', 'now') as INTEGER)),
      PRIMARY KEY("id" AUTOINCREMENT)
    );""");
  }

  Future<List<ProductModel>> getAll() async {
    final database = await DatabaseService().database;
    final todos = await database.rawQuery('''SELECT * FROM $tablename''');
    return todos.map((e) => ProductModel.fromJson(e)).toList();
  }

  Future<List<ProductModel>> show(payload) async {
    final database = await DatabaseService().database;
    final todos = await database
        .rawQuery('''SELECT * FROM $tablename where id=$payload ''');
    return todos.map((e) => ProductModel.fromJson(e)).toList();
  }

  Future<int> create({required String name}) async {
    final database = await DatabaseService().database;
    return await database.rawInsert(
        '''INSERT INTO $tablename (name,created_at,updated_at) VALUES (?,?,?)''',
        [
          name,
          DateTime.now().millisecondsSinceEpoch,
          DateTime.now().millisecondsSinceEpoch
        ]);
  }

  Future<int> update({required int id, required String name}) async {
    final database = await DatabaseService().database;
    return await database.update(
      tablename,
      {"name": name},
      where: "id = ?",
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [id],
    );
  }

  Future<int> delete({required int id}) async {
    final database = await DatabaseService().database;
    return await database.delete(
      tablename,
      where: "id = ?",
      whereArgs: [id],
    );
  }
}

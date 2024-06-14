part of 'database.dart';

class TransactionDB {
  final tablename = 'transcation';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tablename(
      "id" INTEGER NOT NULL,
      "no_transaction" VARCHAR(99) NOT NULL,
      "company_id" INTEGER NOT NULL,
      "date" DATETIME NOT NULL,
      "created_at" INTEGER NOT NULL DEFAULT (cast(strftime('%s', 'now') as INTEGER)),
      "updated_at" INTEGER NOT NULL DEFAULT (cast(strftime('%s', 'now') as INTEGER)),
      PRIMARY KEY("id" AUTOINCREMENT),
      CONSTRAINT FK_Company FOREIGN KEY (company_id)
      REFERENCES company(id)
    );""");
  }

  Future<List<CompanyModel>> getAll() async {
    final database = await DatabaseService().database;
    final todos = await database.rawQuery('''SELECT * FROM $tablename''');
    return todos.map((e) => CompanyModel.fromJson(e)).toList();
  }

  Future<int> create(
      {required String no_transaction,
      required int company_id,
      required DateTime date}) async {
    final database = await DatabaseService().database;
    return await database.rawInsert(
        '''INSERT INTO $tablename (no_transaction,company_id,date,created_at,updated_at) VALUES (?,?,?,?)''',
        [
          no_transaction,
          company_id,
          date,
          DateTime.now().millisecondsSinceEpoch,
          DateTime.now().millisecondsSinceEpoch
        ]);
  }

  Future<int> update(
      {required int id,
      required String no_transaction,
      required int company_id,
      required DateTime date}) async {
    final database = await DatabaseService().database;
    return await database.update(
      tablename,
      {
        "no_transaction": no_transaction,
        "company_id": company_id,
        "date": date
      },
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

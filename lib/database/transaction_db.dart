part of 'database.dart';

class TransactionDB {
  final tablename = 'transcation';
  final tablename_join = 'transcation_detail';
  final tablename_company = 'company';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tablename(
      "id" INTEGER NOT NULL,
      "company_id" INTEGER NOT NULL,
      "date" STRING NOT NULL,
      "created_at" INTEGER NOT NULL DEFAULT (cast(strftime('%s', 'now') as INTEGER)),
      "updated_at" INTEGER NOT NULL DEFAULT (cast(strftime('%s', 'now') as INTEGER)),
      PRIMARY KEY("id" AUTOINCREMENT),
      CONSTRAINT FK_Company FOREIGN KEY (company_id)
      REFERENCES company(id)
    );""");
    await database.execute("""CREATE TABLE IF NOT EXISTS $tablename_join(
      "id" INTEGER NOT NULL,
      "id_transaction" INTEGER NOT NULL,
      "product_id" INTEGER NOT NULL,
      "amount" INTEGER NOT NULL,
      "price" DOUBLE NOT NULL,
      "created_at" INTEGER NOT NULL DEFAULT (cast(strftime('%s', 'now') as INTEGER)),
      "updated_at" INTEGER NOT NULL DEFAULT (cast(strftime('%s', 'now') as INTEGER)),
      PRIMARY KEY("id" AUTOINCREMENT),
      CONSTRAINT FK_Product FOREIGN KEY (product_id)
      REFERENCES product(id),
      CONSTRAINT FK_Transaction FOREIGN KEY (id_transaction)
      REFERENCES transcation(id)
    );""");
  }

  Future<List<TransactionModel>> getAll() async {
    final database = await DatabaseService().database;
    final todos = await database.rawQuery(
        '''SELECT $tablename.*,$tablename_company.name as company_name,$tablename_company.address as address,$tablename_company.phone as phone, sum($tablename_join.amount * $tablename_join.price) as totalprice FROM $tablename 
        INNER JOIN $tablename_join ON $tablename.id = $tablename_join.id_transaction
        INNER JOIN $tablename_company ON $tablename.company_id = $tablename_company.id
        GROUP BY $tablename_join.id_transaction
     ''');
    return todos.map((e) => TransactionModel.fromJson(e)).toList();
  }

  Future<List<TransactionModel>> getFilter(
      int company_id, String start_date, String end_date) async {
    final database = await DatabaseService().database;
    final todos = await database.rawQuery(
        '''SELECT $tablename.*,$tablename_company.name as company_name,$tablename_company.address as address,$tablename_company.phone as phone, sum($tablename_join.amount * $tablename_join.price) as totalprice FROM $tablename 
        INNER JOIN $tablename_join ON $tablename.id = $tablename_join.id_transaction
        INNER JOIN $tablename_company ON $tablename.company_id = $tablename_company.id
        where $tablename.company_id = ${company_id} and $tablename.date between '${start_date}' and '${end_date}' GROUP BY $tablename_join.id_transaction
     ''');
    return todos.map((e) => TransactionModel.fromJson(e)).toList();
  }

  Future<List<TransactionModel>> getLimit() async {
    final database = await DatabaseService().database;
    final todos = await database.rawQuery(
        '''SELECT $tablename.*,$tablename_company.name as company_name, sum($tablename_join.amount * $tablename_join.price) as totalprice FROM $tablename 
        INNER JOIN $tablename_join ON $tablename.id = $tablename_join.id_transaction
        INNER JOIN $tablename_company ON $tablename.company_id = $tablename_company.id
        GROUP BY $tablename_join.id_transaction LIMIT 5
     ''');
    return todos.map((e) => TransactionModel.fromJson(e)).toList();
  }

  Future<List<TransactionDetailModel>> getdetail(int id) async {
    final database = await DatabaseService().database;
    final todos = await database.rawQuery(
        '''SELECT $tablename_join.*,product.name as product_name FROM $tablename_join
         INNER JOIN product ON product.id = $tablename_join.product_id
         where id_transaction = ?''', [id]);
    return todos.map((e) => TransactionDetailModel.fromJson(e)).toList();
  }

  Future<void> create(
      {required int company_id,
      required String date,
      required List<TransactionDetailModel> transaction_detail}) async {
    final database = await DatabaseService().database;
    int id_transaction = await database.rawInsert(
        '''INSERT INTO $tablename (company_id,date,created_at,updated_at) VALUES (?,?,?,?)''',
        [
          company_id,
          date,
          DateTime.now().millisecondsSinceEpoch,
          DateTime.now().millisecondsSinceEpoch
        ]);
    var db = database.batch();
    for (var data in transaction_detail) {
      db.rawInsert(
          '''INSERT INTO $tablename_join (id_transaction,product_id,amount,price,created_at,updated_at) VALUES (?,?,?,?,?,?)''',
          [
            id_transaction,
            data.product_id,
            data.amount,
            data.price,
            DateTime.now().millisecondsSinceEpoch,
            DateTime.now().millisecondsSinceEpoch
          ]);
    }
    await db.commit();
  }

  Future<void> update(
      {required int company_id,
      required String date,
      required List<TransactionDetailModel> transaction_detail,
      required int id}) async {
    final database = await DatabaseService().database;
    await database.update(
      tablename,
      {"company_id": company_id, "date": date},
      where: "id = ?",
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [id],
    );
    await database.delete(
      tablename_join,
      where: "id_transaction = ?",
      whereArgs: [id],
    );
    var db = database.batch();
    for (var data in transaction_detail) {
      db.rawInsert(
          '''INSERT INTO $tablename_join (id_transaction,product_id,amount,price,created_at,updated_at) VALUES (?,?,?,?,?,?)''',
          [
            id,
            data.product_id,
            data.amount,
            data.price,
            DateTime.now().millisecondsSinceEpoch,
            DateTime.now().millisecondsSinceEpoch
          ]);
    }
    await db.commit();
  }

  Future<void> delete({required int id}) async {
    final database = await DatabaseService().database;
    await database.delete(
      tablename,
      where: "id = ?",
      whereArgs: [id],
    );
    await database.delete(
      tablename_join,
      where: "id_transaction = ?",
      whereArgs: [id],
    );
  }
}

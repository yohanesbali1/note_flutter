part of "models.dart";

class TransactionModel {
  final int id;
  final String no_transaction;
  final int company_id;
  final DateTime date;

  TransactionModel(
      {required this.id,
      required this.no_transaction,
      required this.company_id,
      required this.date});
  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
        id: json['id'],
        no_transaction: json['no_transaction'],
        company_id: json['company_id'],
        date: json['date']);
  }
}

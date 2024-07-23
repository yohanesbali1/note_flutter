part of "models.dart";

class TransactionDetailModel {
  final int? id_transaction;
  final int product_id;
  final int amount;
  final String? product_name;
  final double price;

  TransactionDetailModel(
      {this.id_transaction,
      this.product_name,
      required this.product_id,
      required this.price,
      required this.amount});
  factory TransactionDetailModel.fromJson(Map<String, dynamic> json) {
    return TransactionDetailModel(
        id_transaction: json['id_transaction'],
        product_name: json['product_name'],
        product_id: json['product_id'],
        amount: json['amount'],
        price: json['price']);
  }
}

class TransactionFilterModel {
  final int? company_id;
  final String start_date;
  final String end_date;

  TransactionFilterModel(
      {this.company_id, required this.start_date, required this.end_date});
  factory TransactionFilterModel.fromJson(Map<String, dynamic> json) {
    return TransactionFilterModel(
        company_id: json['company_id'],
        start_date: json['start_date'],
        end_date: json['end_date']);
  }
}

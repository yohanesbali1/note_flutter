part of "models.dart";

class TransactionDetailModel {
  final int id;
  final int id_transaction;
  final int product_id;
  final int amount;
  final double price;

  TransactionDetailModel(
      {required this.id,
      required this.id_transaction,
      required this.product_id,
      required this.price,
      required this.amount});
  factory TransactionDetailModel.fromJson(Map<String, dynamic> json) {
    return TransactionDetailModel(
        id: json['id'],
        id_transaction: json['id_transaction'],
        product_id: json['product_id'],
        amount: json['amount'],
        price: json['price']);
  }
}

class TransactionDetailFormModel {
  final int id;
  final int id_transaction;
  final int product_id;
  final int amount;
  final double price;

  TransactionDetailFormModel(
      {required this.id,
      required this.id_transaction,
      required this.product_id,
      required this.price,
      required this.amount});
}

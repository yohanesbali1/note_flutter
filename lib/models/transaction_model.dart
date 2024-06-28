part of "models.dart";

class TransactionModel {
  final int id;
  final double? totalprice;
  final int company_id;
  final String? company_name;
  final String date;

  TransactionModel(
      {this.totalprice,
      required this.id,
      required this.company_id,
      required this.date,
      this.company_name});
  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
        id: json['id'],
        company_id: json['company_id'],
        totalprice: json['totalprice'],
        date: json['date'],
        company_name: json['company_name']);
  }
}

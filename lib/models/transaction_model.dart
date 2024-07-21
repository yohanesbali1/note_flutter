part of "models.dart";

class TransactionModel {
  final int id;
  final double? totalprice;
  final int company_id;
  final String? company_name;
  final String? address;
  final String? phone;
  final String date;

  TransactionModel(
      {this.totalprice,
      required this.id,
      required this.company_id,
      required this.date,
      this.company_name,
      this.address,
      this.phone});
  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
        id: json['id'],
        company_id: json['company_id'],
        totalprice: json['totalprice'],
        date: json['date'],
        company_name: json['company_name'],
        address: json['address'],
        phone: json['phone']);
  }
}

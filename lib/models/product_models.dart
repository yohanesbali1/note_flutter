part of "models.dart";

class ProductModel {
  final int id;
  final String name;
  final int qty;

  ProductModel({required this.id, required this.name, required this.qty});
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(id: json['id'], name: json['name'], qty: json['qty']);
  }
}

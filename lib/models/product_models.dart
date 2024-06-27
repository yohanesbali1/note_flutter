part of "models.dart";

class ProductModel {
  final int id;
  final String name;

  ProductModel({required this.id, required this.name});
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(id: json['id'], name: json['name']);
  }
}

part of "models.dart";

class CompanyModel {
  final int id;
  final String name;
  final String address;

  CompanyModel({required this.id, required this.name, required this.address});
  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
        id: json['id'], name: json['name'], address: json['address']);
  }
}

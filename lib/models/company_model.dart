part of "models.dart";

class CompanyModel {
  final int id;
  final String name;
  final String address;
  final String phone;

  CompanyModel(
      {required this.id,
      required this.name,
      required this.address,
      required this.phone});
  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
        id: json['id'],
        name: json['name'],
        address: json['address'],
        phone: json['phone']);
  }
}

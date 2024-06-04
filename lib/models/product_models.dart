part of "models.dart";

class ProductCollection extends Equatable {
  final String name;
  final double qty;

  const ProductCollection({required this.name, required this.qty});
  factory ProductCollection.fromJson(Map<String, dynamic> json) {
    return ProductCollection(name: json['token'], qty: json['data']);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [name, qty];
}

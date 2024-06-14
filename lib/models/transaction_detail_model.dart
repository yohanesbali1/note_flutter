part of "models.dart";

class PaymentCollection extends Equatable {
  final String name;
  final double qty;
  final double jumlah;

  const PaymentCollection(
      {required this.name, required this.qty, required this.jumlah});
  factory PaymentCollection.fromJson(Map<String, dynamic> json) {
    return PaymentCollection(
        name: json['name'], qty: json['data'], jumlah: json['total']);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [name, qty, jumlah];
}

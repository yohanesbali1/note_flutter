part of "models.dart";

class HistoryCollection extends Equatable {
  final String name;
  final double qty;
  final DateTime date;

  const HistoryCollection(
      {required this.name, required this.qty, required this.date});
  factory HistoryCollection.fromJson(Map<String, dynamic> json) {
    return HistoryCollection(
        name: json['name'], qty: json['data'], date: json['total']);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [name, qty, date];
}

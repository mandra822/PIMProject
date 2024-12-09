import 'package:cloud_firestore/cloud_firestore.dart';

class Expense {
  final String id;
  String item;
  double price;
  String user;
  DateTime date;

  Expense({
    required this.id,
    required this.item,
    required this.price,
    required this.user,
    required this.date,
  });

  Expense copyWith({
    String? id,
    String? item,
    double? price,
    String? user,
    DateTime? date,
  }) {
    return Expense(
      id: id ?? this.id,
      item: item ?? this.item,
      price: price ?? this.price,
      user: user ?? this.user,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'item': item,
      'price': price,
      'user': user,
      'date': date,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map, String id) {
    return Expense(
      id: id,
      item: map['item'] ?? 'Unknown Item',
      price: map['price']?.toDouble() ?? 0.0,
      user: map['user'] ?? 'Unknown User',
      date: map['date'] != null
          ? DateTime(
              (map['date'] as Timestamp).toDate().year,
              (map['date'] as Timestamp).toDate().month,
              (map['date'] as Timestamp).toDate().day,
            )
          : DateTime.now(),
    );
  }
}

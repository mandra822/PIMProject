import 'package:cloud_firestore/cloud_firestore.dart';

class Expense {
  final String id;
  final String item;
  final double price;
  final String user;
  final DateTime date;
  final bool didYouPay;
  final bool didYouSplit;

  Expense({
    required this.id,
    required this.item,
    required this.price,
    required this.user,
    required this.date,
    required this.didYouPay,
    required this.didYouSplit,
  });

  Expense copyWith({
    String? id,
    String? item,
    double? price,
    String? user,
    DateTime? date,
    bool? didYouPay,
    bool? didYouSplit,
  }) {
    return Expense(
      id: id ?? this.id,
      item: item ?? this.item,
      price: price ?? this.price,
      user: user ?? this.user,
      date: date ?? this.date,
      didYouPay: didYouPay ?? this.didYouPay,
      didYouSplit: didYouSplit ?? this.didYouSplit,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'item': item,
      'price': price,
      'user': user,
      'date': date,
      'didYouPay': didYouPay,
      'didYouSplit': didYouSplit,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map, String id) {
    return Expense(
      id: id,
      item: map['item'] ?? 'Unknown Item', 
      price: map['price']?.toDouble() ?? 0.0,
      user: map['user'] ?? 'Unknown User', 
      date: map['date'] != null ? (map['date'] as Timestamp).toDate() : DateTime.now(),
      didYouPay: map['didYouPay'] ?? false,
      didYouSplit: map['didYouSplit'] ?? false,
    );
  }
}

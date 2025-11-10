// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Transaction {
  final int? id;
  final String type;
  final String category;
  final String description;
  final double amount;
  final String date;

  Transaction({
    this.id,
    required this.type,
    required this.category,
    required this.description,
    required this.amount,
    required this.date,
  });

  Transaction copyWith({
    int? id,
    String? type,
    String? category,
    String? description,
    double? amount,
    String? date,
  }) {
    return Transaction(
      id: id ?? this.id,
      type: type ?? this.type,
      category: category ?? this.category,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type,
      'category': category,
      'description': description,
      'amount': amount,
      'date': date,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'] != null ? map['id'] as int : null,
      type: map['type'] as String,
      category: map['category'] as String,
      description: map['description'] as String,
      amount: map['amount'] as double,
      date: map['date'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) =>
      Transaction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Transaction(id: $id, type: $type, category: $category, description: $description, amount: $amount, date: $date)';
  }

  @override
  bool operator ==(covariant Transaction other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.type == type &&
        other.category == category &&
        other.description == description &&
        other.amount == amount &&
        other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        type.hashCode ^
        category.hashCode ^
        description.hashCode ^
        amount.hashCode ^
        date.hashCode;
  }
}

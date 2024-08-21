import 'package:hive_flutter/adapters.dart';
import 'package:money_management_app/model/category/category_model.dart';
part 'transactions_model.g.dart';

@HiveType(typeId: 3) //1 and 2 tables present
class TransactionModel {
  @HiveField(0)
  final String purpose;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final CategoryType cat_type;

  @HiveField(4)
  final CategoryModel category;

  @HiveField(5)
  String? id;

  TransactionModel({
    required this.purpose,
    required this.amount,
    required this.date,
    required this.cat_type,
    required this.category,
  }) {
    id = DateTime.now().millisecondsSinceEpoch.toString();
  }
}

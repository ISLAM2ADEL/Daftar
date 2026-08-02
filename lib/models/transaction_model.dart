import 'package:hive/hive.dart';

part 'transaction_model.g.dart';

@HiveType(typeId: 2)
enum TransactionType {
  @HiveField(0)
  debt, // "دين" — increases customer's balance (they owe more)

  @HiveField(1)
  payment, // "معاملة" — decreases customer's balance (they paid back)
}

@HiveType(typeId: 1)
class TransactionModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String customerId;

  @HiveField(2)
  double amount; // always stored positive

  @HiveField(3)
  TransactionType type;

  @HiveField(4)
  String? note;

  @HiveField(5)
  DateTime date;

  TransactionModel({
    required this.id,
    required this.customerId,
    required this.amount,
    required this.type,
    this.note,
    required this.date,
  });
}

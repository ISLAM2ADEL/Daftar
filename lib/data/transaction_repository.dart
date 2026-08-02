import 'package:hive/hive.dart';
import 'package:daftra/data/hive_boxes.dart';
import 'package:daftra/models/transaction_model.dart';

class TransactionRepository {
  Box<TransactionModel> get _box =>
      Hive.box<TransactionModel>(transactionsBox);

  /// Returns all transactions for a specific customer, sorted newest first.
  List<TransactionModel> getForCustomer(String customerId) {
    final list = _box.values
        .where((t) => t.customerId == customerId)
        .toList();
    list.sort((a, b) => b.date.compareTo(a.date));
    return list;
  }

  /// Returns all transactions across all customers.
  List<TransactionModel> getAll() => _box.values.toList();

  /// Adds a new transaction.
  Future<void> add(TransactionModel transaction) async {
    await _box.put(transaction.id, transaction);
  }
}

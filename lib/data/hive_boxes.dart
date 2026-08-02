import 'package:hive_flutter/hive_flutter.dart';
import 'package:daftra/models/customer_model.dart';
import 'package:daftra/models/transaction_model.dart';

const String customersBox = 'customers';
const String transactionsBox = 'transactions';
const String settingsBox = 'settings';

Future<void> initHive() async {
  await Hive.initFlutter();

  // Register adapters
  Hive.registerAdapter(CustomerModelAdapter());
  Hive.registerAdapter(TransactionModelAdapter());
  Hive.registerAdapter(TransactionTypeAdapter());

  // Open boxes
  await Hive.openBox<CustomerModel>(customersBox);
  await Hive.openBox<TransactionModel>(transactionsBox);
  await Hive.openBox(settingsBox);
}

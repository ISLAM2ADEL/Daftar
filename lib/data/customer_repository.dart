import 'package:hive/hive.dart';
import 'package:daftra/data/hive_boxes.dart';
import 'package:daftra/models/customer_model.dart';

class CustomerRepository {
  Box<CustomerModel> get _box => Hive.box<CustomerModel>(customersBox);

  /// Returns all customers.
  List<CustomerModel> getAll() => _box.values.toList();

  /// Adds a new customer to the box.
  Future<void> add(CustomerModel customer) async {
    await _box.put(customer.id, customer);
  }

  /// Finds a customer by id. Returns null if not found.
  CustomerModel? findById(String id) => _box.get(id);

  /// Adjusts a customer's balance by [delta] and persists the change.
  /// Positive delta = more debt; negative delta = payment reducing debt.
  Future<void> adjustBalance(String id, double delta) async {
    final customer = _box.get(id);
    if (customer != null) {
      customer.balance += delta;
      await customer.save();
    }
  }

  /// Returns true if a customer with [phone] already exists.
  bool phoneExists(String phone) =>
      _box.values.any((c) => c.phone == phone);
}

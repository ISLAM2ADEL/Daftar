import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:daftra/cubits/customers_state.dart';
import 'package:daftra/data/customer_repository.dart';
import 'package:daftra/data/transaction_repository.dart';
import 'package:daftra/models/customer_model.dart';

class CustomersCubit extends Cubit<CustomersState> {
  final CustomerRepository _customerRepo;
  final TransactionRepository _transactionRepo;

  CustomersCubit({
    required CustomerRepository customerRepository,
    required TransactionRepository transactionRepository,
  })  : _customerRepo = customerRepository,
        _transactionRepo = transactionRepository,
        super(const CustomersState());

  /// Loads all customers and transactions from Hive.
  void loadCustomers() {
    emit(state.copyWith(isLoading: true));
    final customers = _customerRepo.getAll();
    final transactions = _transactionRepo.getAll();
    customers.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    emit(state.copyWith(
      allCustomers: customers,
      filteredCustomers: customers,
      allTransactions: transactions,
      searchQuery: '',
      isLoading: false,
    ));
  }

  /// Filters customers by name or phone (case-insensitive).
  void search(String query) {
    final q = query.trim().toLowerCase();
    final filtered = q.isEmpty
        ? state.allCustomers
        : state.allCustomers
            .where((c) =>
                c.name.toLowerCase().contains(q) ||
                c.phone.toLowerCase().contains(q))
            .toList();
    emit(state.copyWith(
      searchQuery: query,
      filteredCustomers: filtered,
    ));
  }

  /// Creates a new customer and persists it.
  Future<void> addCustomer(String name, String phone) async {
    final customer = CustomerModel(
      id: const Uuid().v4(),
      name: name,
      phone: phone,
      balance: 0,
      createdAt: DateTime.now(),
    );
    await _customerRepo.add(customer);
    loadCustomers();
  }

  /// Returns true if a customer with [phone] already exists.
  bool phoneExists(String phone) => _customerRepo.phoneExists(phone);
}

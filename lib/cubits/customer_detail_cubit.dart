import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:daftra/cubits/customer_detail_state.dart';
import 'package:daftra/data/customer_repository.dart';
import 'package:daftra/data/transaction_repository.dart';
import 'package:daftra/models/customer_model.dart';
import 'package:daftra/models/transaction_model.dart';

class CustomerDetailCubit extends Cubit<CustomerDetailState> {
  final TransactionRepository _transactionRepo;
  final CustomerRepository _customerRepo;

  CustomerDetailCubit({
    required CustomerModel customer,
    required TransactionRepository transactionRepository,
    required CustomerRepository customerRepository,
  })  : _transactionRepo = transactionRepository,
        _customerRepo = customerRepository,
        super(CustomerDetailState(customer: customer));

  /// Loads transactions for the current customer.
  void loadTransactions() {
    emit(state.copyWith(isLoading: true));
    final transactions =
        _transactionRepo.getForCustomer(state.customer.id);
    emit(state.copyWith(transactions: transactions, isLoading: false));
  }

  /// Adds a transaction, updates the customer's cached balance, and reloads.
  Future<void> addTransaction({
    required double amount,
    required TransactionType type,
    String? note,
  }) async {
    final transaction = TransactionModel(
      id: const Uuid().v4(),
      customerId: state.customer.id,
      amount: amount,
      type: type,
      note: note,
      date: DateTime.now(),
    );

    await _transactionRepo.add(transaction);

    // debt → balance goes up (customer owes more)
    // payment → balance goes down (customer paid back)
    final delta = type == TransactionType.debt ? amount : -amount;
    await _customerRepo.adjustBalance(state.customer.id, delta);

    // Reload the refreshed customer from the box
    final updatedCustomer = _customerRepo.findById(state.customer.id);
    final transactions =
        _transactionRepo.getForCustomer(state.customer.id);

    emit(state.copyWith(
      customer: updatedCustomer ?? state.customer,
      transactions: transactions,
      isLoading: false,
    ));
  }
}

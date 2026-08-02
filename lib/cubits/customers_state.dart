import 'package:equatable/equatable.dart';
import 'package:daftra/models/customer_model.dart';
import 'package:daftra/models/transaction_model.dart';

class CustomersState extends Equatable {
  final List<CustomerModel> allCustomers;
  final List<CustomerModel> filteredCustomers;
  final List<TransactionModel> allTransactions;
  final String searchQuery;
  final bool isLoading;

  const CustomersState({
    this.allCustomers = const [],
    this.filteredCustomers = const [],
    this.allTransactions = const [],
    this.searchQuery = '',
    this.isLoading = false,
  });

  /// Total outstanding debt: sum of all positive customer balances.
  double get totalDebt => allCustomers
      .where((c) => c.balance > 0)
      .fold(0.0, (sum, c) => sum + c.balance);

  /// Total ever collected: sum of all payment-type transaction amounts.
  double get totalCollected => allTransactions
      .where((t) => t.type == TransactionType.payment)
      .fold(0.0, (sum, t) => sum + t.amount);

  CustomersState copyWith({
    List<CustomerModel>? allCustomers,
    List<CustomerModel>? filteredCustomers,
    List<TransactionModel>? allTransactions,
    String? searchQuery,
    bool? isLoading,
  }) {
    return CustomersState(
      allCustomers: allCustomers ?? this.allCustomers,
      filteredCustomers: filteredCustomers ?? this.filteredCustomers,
      allTransactions: allTransactions ?? this.allTransactions,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        allCustomers,
        filteredCustomers,
        allTransactions,
        searchQuery,
        isLoading,
      ];
}

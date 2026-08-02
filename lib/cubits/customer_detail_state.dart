import 'package:equatable/equatable.dart';
import 'package:daftra/models/customer_model.dart';
import 'package:daftra/models/transaction_model.dart';

class CustomerDetailState extends Equatable {
  final CustomerModel customer;
  final List<TransactionModel> transactions;
  final bool isLoading;

  const CustomerDetailState({
    required this.customer,
    this.transactions = const [],
    this.isLoading = false,
  });

  CustomerDetailState copyWith({
    CustomerModel? customer,
    List<TransactionModel>? transactions,
    bool? isLoading,
  }) {
    return CustomerDetailState(
      customer: customer ?? this.customer,
      transactions: transactions ?? this.transactions,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [customer, transactions, isLoading];
}

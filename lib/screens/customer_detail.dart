import 'package:daftra/cubits/customer_detail_cubit.dart';
import 'package:daftra/cubits/customer_detail_state.dart';
import 'package:daftra/data/customer_repository.dart';
import 'package:daftra/data/transaction_repository.dart';
import 'package:daftra/models/customer_model.dart';
import 'package:daftra/models/transaction_model.dart';
import 'package:daftra/widgets/add_payment_method.dart';
import 'package:daftra/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CustomerDetailScreen extends StatelessWidget {
  const CustomerDetailScreen({super.key, required this.customer});

  final CustomerModel customer;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CustomerDetailCubit(
        customer: customer,
        transactionRepository: TransactionRepository(),
        customerRepository: CustomerRepository(),
      )..loadTransactions(),
      child: _CustomerDetailBody(customer: customer),
    );
  }
}

class _CustomerDetailBody extends StatelessWidget {
  const _CustomerDetailBody({required this.customer});

  final CustomerModel customer;

  Color _balanceColor(BuildContext context, double balance) {
    if (balance > 0) return Theme.of(context).colorScheme.secondary; // red/debt
    if (balance < 0) return Theme.of(context).colorScheme.primary;   // green/credit
    return Colors.grey;
  }

  String _balanceLabel(double balance) {
    if (balance > 0) return 'عليه دين';
    if (balance < 0) return 'له رصيد';
    return 'مصفى';
  }

  String _formatMoney(double amount) {
    final fmt = NumberFormat('#,##0.##', 'ar');
    return fmt.format(amount.abs());
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy – HH:mm', 'ar').format(date);
  }

  Color _txColor(BuildContext context, TransactionType type) {
    return type == TransactionType.debt
        ? Theme.of(context).colorScheme.secondary
        : Theme.of(context).colorScheme.primary;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: CustomAppBar(
        text: customer.name,
        leadingicon: Icons.arrow_back,
        onLeadingPressed: () => Navigator.pop(context),
      ),
      body: BlocBuilder<CustomerDetailCubit, CustomerDetailState>(
        builder: (context, state) {
          final bal = state.customer.balance;
          return Column(
            children: [
              const Divider(color: Colors.grey),

              // ── Balance summary block ──────────────────────────────────
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Text(
                      '${_formatMoney(bal)} ج.م',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: _balanceColor(context, bal),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: _balanceColor(context, bal).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _balanceLabel(bal),
                        style: TextStyle(
                          fontSize: 14,
                          color: _balanceColor(context, bal),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'هاتف: ${state.customer.phone}',
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ],
                ),
              ),

              // ── Transactions list ──────────────────────────────────────
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Row(
                  children: const [
                    Text(
                      'سجل المعاملات',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              if (state.isLoading)
                const Expanded(
                    child: Center(child: CircularProgressIndicator()))
              else if (state.transactions.isEmpty)
                const Expanded(
                  child: Center(
                    child: Text(
                      'لا توجد معاملات بعد',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                )
              else
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    itemCount: state.transactions.length,
                    separatorBuilder: (context, idx) =>
                        const Divider(height: 1, color: Colors.grey),
                    itemBuilder: (context, i) {
                      final tx = state.transactions[i];
                      final isDebt = tx.type == TransactionType.debt;
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color:
                                _txColor(context, tx.type).withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isDebt
                                ? Icons.arrow_upward
                                : Icons.arrow_downward,
                            color: _txColor(context, tx.type),
                            size: 20,
                          ),
                        ),
                        title: Text(
                          isDebt ? 'دين' : 'معاملة',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _txColor(context, tx.type),
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (tx.note != null && tx.note!.isNotEmpty)
                              Text(tx.note!,
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 12)),
                            Text(
                              _formatDate(tx.date),
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 11),
                            ),
                          ],
                        ),
                        trailing: Text(
                          '${isDebt ? '+' : '-'}${_formatMoney(tx.amount)} ج.م',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: _txColor(context, tx.type),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
      floatingActionButton: Builder(
        builder: (ctx) => AddPaymentMethod(height: height),
      ),
    );
  }
}

import 'package:daftra/cubits/customer_detail_cubit.dart';
import 'package:daftra/models/transaction_model.dart';
import 'package:daftra/widgets/custom_textform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// FAB that opens a bottom sheet for recording a debt (دين) or payment (معاملة).
/// Must be placed where a [CustomerDetailCubit] is in scope (i.e. inside
/// CustomerDetailScreen's BlocProvider tree).
class AddPaymentMethod extends StatefulWidget {
  const AddPaymentMethod({super.key, required this.height});

  final double height;

  @override
  State<AddPaymentMethod> createState() => _AddPaymentMethodState();
}

class _AddPaymentMethodState extends State<AddPaymentMethod> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _openSheet(context),
      child: const Icon(Icons.add),
    );
  }

  void _openSheet(BuildContext parentContext) {
    showModalBottomSheet(
      context: parentContext,
      isScrollControlled: true,
      builder: (BuildContext ctx) {
        return _PaymentSheet(
          height: widget.height,
          cubit: parentContext.read<CustomerDetailCubit>(),
        );
      },
    );
  }
}

/// Stateful inner widget so each bottom-sheet open gets fresh controllers.
class _PaymentSheet extends StatefulWidget {
  const _PaymentSheet({required this.height, required this.cubit});

  final double height;
  final CustomerDetailCubit cubit;

  @override
  State<_PaymentSheet> createState() => _PaymentSheetState();
}

class _PaymentSheetState extends State<_PaymentSheet>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  // Debt tab controllers
  final _debtAmountCtrl = TextEditingController();
  final _debtNoteCtrl = TextEditingController();

  // Payment tab controllers
  final _paymentAmountCtrl = TextEditingController();
  final _paymentNoteCtrl = TextEditingController();

  String? _errorMsg;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _debtAmountCtrl.dispose();
    _debtNoteCtrl.dispose();
    _paymentAmountCtrl.dispose();
    _paymentNoteCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final isDebtTab = _tabController.index == 0;
    final amountText =
        isDebtTab ? _debtAmountCtrl.text : _paymentAmountCtrl.text;
    final noteText =
        isDebtTab ? _debtNoteCtrl.text : _paymentNoteCtrl.text;

    final amount = double.tryParse(amountText.trim());
    if (amount == null || amount <= 0) {
      setState(() => _errorMsg = 'برجاء ادخال مبلغ صحيح أكبر من صفر');
      return;
    }

    setState(() => _errorMsg = null);

    await widget.cubit.addTransaction(
      amount: amount,
      type: isDebtTab ? TransactionType.debt : TransactionType.payment,
      note: noteText.trim().isEmpty ? null : noteText.trim(),
    );

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Push the sheet up when the keyboard opens
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SizedBox(
        height: widget.height * .52,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'إضافة معاملة',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'دين'),
                  Tab(text: 'معاملة'),
                ],
              ),

              const SizedBox(height: 16),

              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _paymentBody(
                      amountCtrl: _debtAmountCtrl,
                      noteCtrl: _debtNoteCtrl,
                    ),
                    _paymentBody(
                      amountCtrl: _paymentAmountCtrl,
                      noteCtrl: _paymentNoteCtrl,
                    ),
                  ],
                ),
              ),

              if (_errorMsg != null) ...[
                const SizedBox(height: 8),
                Text(
                  _errorMsg!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],

              const SizedBox(height: 12),

              ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'حفظ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _paymentBody({
    required TextEditingController amountCtrl,
    required TextEditingController noteCtrl,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('المبلغ', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 6),
        CustomTextform(
          controller: amountCtrl,
          suffix: const Icon(Icons.attach_money_outlined),
          text: '0.00',
          isNumber: true,
          validator: (_) => null,
        ),
        const SizedBox(height: 12),
        const Text('ملاحظة (اختياري)', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 6),
        CustomTextform(
          controller: noteCtrl,
          suffix: const Icon(Icons.note_alt_outlined),
          text: 'أضف ملاحظة...',
          validator: (_) => null,
        ),
      ],
    );
  }
}

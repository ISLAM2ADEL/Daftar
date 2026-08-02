import 'package:daftra/cubits/customers_cubit.dart';
import 'package:daftra/cubits/customers_state.dart';
import 'package:daftra/models/customer_model.dart';
import 'package:daftra/screens/customer_detail.dart';
import 'package:daftra/screens/customers.dart';
import 'package:daftra/screens/settings.dart';
import 'package:daftra/utils/custom_customer_container.dart';
import 'package:daftra/widgets/custom_appbar.dart';
import 'package:daftra/widgets/custom_buttonbar.dart';
import 'package:daftra/widgets/custom_container.dart';
import 'package:daftra/widgets/custom_textform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  String _formatMoney(double amount) {
    final fmt = NumberFormat('#,##0.##', 'ar');
    return fmt.format(amount);
  }

  int _choice(CustomerModel c) {
    if (c.balance > 0) return 1;
    if (c.balance < 0) return 2;
    return 0;
  }

  String _moneyDisplay(CustomerModel c) {
    final fmt = NumberFormat('#,##0.##', 'ar');
    if (c.balance > 0) return '+${fmt.format(c.balance)}';
    if (c.balance < 0) return fmt.format(c.balance);
    return '0';
  }

  String _lastActivity(CustomerModel c) {
    final fmt = DateFormat('dd/MM/yyyy', 'ar');
    return fmt.format(c.createdAt);
  }

  void _navigate(BuildContext context, int index) {
    if (index == 2) return; // already home
    if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const CustomersScreen()),
      );
    } else if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SettingsScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<CustomersCubit, CustomersState>(
          builder: (context, state) {
            // Show only 3 most-recently-created customers
            final recentCustomers = state.allCustomers.take(3).toList();

            return SingleChildScrollView(
              child: Column(
                children: [
                  CustomAppBar(
                    text: 'دفتر',
                    trailingicon: Icons.refresh_outlined,
                    onTrailingPressed: () =>
                        context.read<CustomersCubit>().loadCustomers(),
                  ),

                  const Divider(color: Colors.grey),

                  SizedBox(height: height * .02),

                  // ── Stat Cards ─────────────────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomContainer(
                        width: width,
                        height: height,
                        contColor:
                            Theme.of(context).colorScheme.secondary,
                        headText: 'إجمالي الدين',
                        secondaryText: _formatMoney(state.totalDebt),
                      ),
                      CustomContainer(
                        width: width,
                        height: height,
                        contColor:
                            Theme.of(context).colorScheme.primary,
                        headText: 'إجمالي المحصل',
                        secondaryText:
                            _formatMoney(state.totalCollected),
                      ),
                    ],
                  ),

                  SizedBox(height: height * .02),

                  // ── Search (navigates to Customers screen on submit) ───
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * .05),
                    child: CustomTextform(
                      text: 'ابحث عن عميل ...',
                      suffix: const Icon(Icons.search),
                      validator: (_) => null,
                      onChanged: (_) {
                        // Navigate to CustomersScreen where real search is
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const CustomersScreen()),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: height * .035),

                  // ── Recent customers header ────────────────────────────
                  Container(
                    width: width * .9,
                    height: height * .055,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('سجل العملاء'),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const CustomersScreen()),
                            ),
                            child: Text(
                              'عرض الكل',
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ── Recent customer rows ───────────────────────────────
                  if (state.isLoading)
                    const Padding(
                      padding: EdgeInsets.all(32),
                      child: CircularProgressIndicator(),
                    )
                  else if (recentCustomers.isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(32),
                      child: const Text(
                        'لا يوجد عملاء بعد\nأضف عميلاً لبدء التتبع',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    )
                  else
                    ...recentCustomers.map(
                      (c) => GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                CustomerDetailScreen(customer: c),
                          ),
                        ),
                        child: CustomCustomerContainer(
                          height: height,
                          width: width,
                          name: c.name,
                          date: _lastActivity(c),
                          choice: _choice(c),
                          money: _moneyDisplay(c),
                        ),
                      ),
                    ),

                  SizedBox(height: height * .02),
                ],
              ),
            );
          },
        ),
      ),
      // FAB → navigate to CustomersScreen to pick a customer first
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CustomersScreen()),
        ),
        child: const Icon(Icons.people),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: CustomBottomBar(
        currentIndex: 2,
        onTap: (i) => _navigate(context, i),
      ),
    );
  }
}

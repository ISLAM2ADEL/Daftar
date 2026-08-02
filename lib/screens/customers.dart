import 'package:daftra/cubits/customers_cubit.dart';
import 'package:daftra/cubits/customers_state.dart';
import 'package:daftra/models/customer_model.dart';
import 'package:daftra/screens/add_customer.dart';
import 'package:daftra/screens/customer_detail.dart';
import 'package:daftra/screens/home.dart';
import 'package:daftra/screens/settings.dart';
import 'package:daftra/utils/custom_customer_container.dart';
import 'package:daftra/widgets/custom_appbar.dart';
import 'package:daftra/widgets/custom_buttonbar.dart';
import 'package:daftra/widgets/custom_textform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  String _formatMoney(double balance) {
    final fmt = NumberFormat('#,##0.##', 'ar');
    if (balance > 0) return '+${fmt.format(balance)}';
    if (balance < 0) return fmt.format(balance); // already has - sign
    return '0';
  }

  int _choice(CustomerModel c) {
    if (c.balance > 0) return 1; // debt/red
    if (c.balance < 0) return 2; // credit/green
    return 0; // settled/grey
  }

  String _lastActivity(CustomerModel c) {
    final fmt = DateFormat('dd/MM/yyyy', 'ar');
    return fmt.format(c.createdAt);
  }

  void _navigate(BuildContext context, int index) {
    if (index == 1) return; // already here
    if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Home()),
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
      appBar: CustomAppBar(text: 'العملاء'),
      body: SafeArea(
        child: Column(
          children: [
            const Divider(color: Colors.grey),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * .05,
                vertical: 8,
              ),
              child: CustomTextform(
                text: 'ابحث عن عميل ...',
                suffix: const Icon(Icons.search),
                validator: (_) => null,
                onChanged: (q) =>
                    context.read<CustomersCubit>().search(q),
              ),
            ),
            Expanded(
              child: BlocBuilder<CustomersCubit, CustomersState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.filteredCustomers.isEmpty) {
                    return const Center(
                      child: Text(
                        'لا يوجد عملاء بعد',
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: state.filteredCustomers.length,
                    itemBuilder: (context, index) {
                      final customer = state.filteredCustomers[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  CustomerDetailScreen(customer: customer),
                            ),
                          );
                        },
                        child: CustomCustomerContainer(
                          height: height,
                          width: width,
                          name: customer.name,
                          date: _lastActivity(customer),
                          choice: _choice(customer),
                          money: _formatMoney(customer.balance),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const Addcustomer()),
          );
          // Reload after returning (in case a customer was added)
          if (context.mounted) {
            context.read<CustomersCubit>().loadCustomers();
          }
        },
        child: const Icon(Icons.person_add),
      ),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: 1,
        onTap: (i) => _navigate(context, i),
      ),
    );
  }
}

/// Wires the search field on CustomersScreen to the cubit.
/// Used as a callback inside the search CustomTextform's onChanged.
extension CustomersScreenSearch on CustomersScreen {
  void onSearch(BuildContext context, String query) {
    context.read<CustomersCubit>().search(query);
  }
}

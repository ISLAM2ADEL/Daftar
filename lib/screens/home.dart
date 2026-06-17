import 'package:daftra/widgets/add_payment_method.dart';
import 'package:daftra/widgets/custom_appbar.dart';
import 'package:daftra/widgets/custom_textform.dart';
import 'package:daftra/widgets/custom_buttonbar.dart';
import 'package:daftra/widgets/custom_container.dart';
import 'package:daftra/utils/custom_customer_container.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(
                text: "دفتر",
                leadingicon: Icons.search,
                trailingicon: Icons.refresh_outlined,
              ),

              const Divider(color: Colors.grey),

              SizedBox(height: height * .02),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomContainer(
                    width: width,
                    height: height,
                    contColor: Theme.of(context).colorScheme.secondary,
                    headText: 'إجمالي الدين',
                    secondaryText: '12,500',
                  ),
                  CustomContainer(
                    width: width,
                    height: height,
                    contColor: Theme.of(context).colorScheme.primary,
                    headText: 'إجمالي المحصل',
                    secondaryText: '8,200',
                  ),
                ],
              ),

              SizedBox(height: height * .02),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * .05),
                child: CustomTextform(
                  text: "ابحث عن عميل ...",
                  suffix: const Icon(Icons.search),
                  validator: (value) {
                    return null;
                  },
                ),
              ),

              SizedBox(height: height * .035),

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
                      const Text("سجل العملاء"),
                      Text(
                        "عرض الكل",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              CustomCustomerContainer(
                height: height,
                width: width,
                name: 'أحمد محمود',
                date: 'اليوم، ١٠:٣٠ ص',
                choice: 1,
                money: '450 -',
              ),

              CustomCustomerContainer(
                height: height,
                width: width,
                name: 'أحمد محمود',
                date: 'أمس',
                choice: 2,
                money: '1,200 +',
              ),

              CustomCustomerContainer(
                height: height,
                width: width,
                name: 'أحمد محمود',
                date: '١٢ اكتوبر',
                choice: 0,
                money: '0',
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: AddPaymentMethod(height: height),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: CustomBottomBar(),
    );
  }
}

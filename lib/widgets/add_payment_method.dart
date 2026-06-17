import 'package:daftra/widgets/customTextForm.dart';
import 'package:flutter/material.dart';

class AddPaymentMethod extends StatelessWidget {
  const AddPaymentMethod({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext ctx) {
            return SizedBox(
              height: height * .4,
              child: DefaultTabController(
                length: 2,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("إضافة معاملة"),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      const TabBar(
                        tabs: [
                          Tab(text: "دين"),
                          Tab(text: "معاملة"),
                        ],
                      ),

                      const SizedBox(height: 16),

                      Expanded(
                        child: TabBarView(
                          children: [paymentBody(), paymentBody()],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      child: const Icon(Icons.add),
    );
  }

  Column paymentBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("المبلغ", style: TextStyle(fontSize: 16)),
        CustomTextform(
          suffix: Icon(Icons.attach_money_outlined),
          text: "0.00",
          isNumber: true,
          validator: (value) {
            return null;
          },
        ),
        Text("ملاحظة (اختياري)", style: TextStyle(fontSize: 16)),
        CustomTextform(
          suffix: Icon(Icons.note_alt_outlined),
          text: "0.00",
          validator: (value) {
            return null;
          },
        ),
      ],
    );
  }
}

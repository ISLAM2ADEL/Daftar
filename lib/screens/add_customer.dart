import 'package:daftra/utils/label_textform.dart';
import 'package:daftra/widgets/custom_appbar.dart';
import 'package:daftra/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class Addcustomer extends StatelessWidget {
  const Addcustomer({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: CustomAppBar(
        text: 'اضافة عميل جديد',
        leadingicon: Icons.arrow_back,
        onLeadingPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: MediaQuery.orientationOf(context) == Orientation.portrait
              ? const EdgeInsets.symmetric(vertical: 30, horizontal: 20)
              : const EdgeInsets.symmetric(vertical: 15, horizontal: 60),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Labeltextform(
                  text: 'اسم العميل',
                  textform: 'ادخل اسم العميل',
                  suffix: Icon(
                    Icons.person,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ' برجاء ادخل اسم العميل';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height:
                      MediaQuery.orientationOf(context) == Orientation.portrait
                      ? MediaQuery.sizeOf(context).width * 0.05
                      : MediaQuery.sizeOf(context).width * 0.025,
                ),
                Labeltextform(
                  text: 'رقم الهاتف',
                  textform: "ادخل رقم الهاتف مثل 01012345678",
                  suffix: Icon(
                    Icons.phone,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  validator: (value) {
                    final RegExp phoneRegx = RegExp(r'^01[0125][0-9]{8}$');
                    if (value == null || value.isEmpty) {
                      return 'برجاء ادخال رقم الهاتف';
                    } else if (!phoneRegx.hasMatch(value)) {
                      return 'برجاء ادخال رقم هاتف صحيح';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height:
                      MediaQuery.orientationOf(context) == Orientation.portrait
                      ? MediaQuery.sizeOf(context).width * 0.05
                      : MediaQuery.sizeOf(context).width * 0.025,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      debugPrint("Form is valid! Proceeding to log in...");
                    } else {
                      debugPrint("Form is invalid.");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: "اضافة عميل",
                        isBold: true,
                        color: Theme.of(context).colorScheme.surface,
                        fontSize: 15,
                        align: TextAlign.center,
                      ),
                      SizedBox(
                        width:
                            MediaQuery.orientationOf(context) ==
                                Orientation.portrait
                            ? MediaQuery.sizeOf(context).width * 0.02
                            : MediaQuery.sizeOf(context).width * 0.005,
                      ),
                      Icon(
                        Icons.person_add,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

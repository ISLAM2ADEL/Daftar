import 'package:daftra/utils/labelTextForm.dart';
import 'package:daftra/widgets/customText.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: MediaQuery.orientationOf(context) == Orientation.portrait
                ? const EdgeInsets.symmetric(vertical: 10, horizontal: 20)
                : const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  CustomText(
                    text: "تسجيل الدخول",
                    isBold: true,
                    fontSize:
                        MediaQuery.orientationOf(context) ==
                            Orientation.portrait
                        ? MediaQuery.sizeOf(context).width * 0.075
                        : MediaQuery.sizeOf(context).width * 0.04,
                    color: Theme.of(context).colorScheme.onSurface,
                    align: TextAlign.center,
                  ),
                  SizedBox(
                    height:
                        MediaQuery.orientationOf(context) ==
                            Orientation.portrait
                        ? MediaQuery.sizeOf(context).width * 0.2
                        : MediaQuery.sizeOf(context).width * 0.05,
                  ),
                  Labeltextform(
                    text: "رقم الهاتف",
                    isBold: true,
                    fontSize:
                        MediaQuery.orientationOf(context) ==
                            Orientation.portrait
                        ? MediaQuery.sizeOf(context).width * 0.03
                        : MediaQuery.sizeOf(context).width * 0.02,
                    suffix: const Icon(Icons.phone_android_rounded),
                    textform: "ادخل رقم الهاتف مثل 01012345678",
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
                        MediaQuery.orientationOf(context) ==
                            Orientation.portrait
                        ? MediaQuery.sizeOf(context).width * 0.05
                        : MediaQuery.sizeOf(context).width * 0.025,
                  ),
                  Labeltextform(
                    text: "كلمة المرور",
                    isBold: true,
                    fontSize:
                        MediaQuery.orientationOf(context) ==
                            Orientation.portrait
                        ? MediaQuery.sizeOf(context).width * 0.03
                        : MediaQuery.sizeOf(context).width * 0.02,
                    suffix: const Icon(Icons.lock),
                    textform: "ادخل كلمة المرور يتكون من 8 حروف علي الاقل",
                    validator: (value) {
                      final RegExp passwordRegx = RegExp(
                        r'^(?=.*[A-Za-z])(?=.*\d).{8,}$',
                      );
                      if (value == null || value.isEmpty) {
                        return 'برجاء ادخال كلمة المرور';
                      } else if (!passwordRegx.hasMatch(value)) {
                        return 'برجاء ادخال كلمة مرور صحيحة';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
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
                    child: CustomText(
                      text: "تسجيل الدخول",
                      isBold: true,
                      color: Theme.of(context).colorScheme.surface,
                      fontSize: 15,
                      align: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height:
                        MediaQuery.orientationOf(context) ==
                            Orientation.portrait
                        ? MediaQuery.sizeOf(context).width * 0.05
                        : MediaQuery.sizeOf(context).width * 0.025,
                  ),
                  InkWell(
                    child: CustomText(
                      text: "ليس لديك حساب؟ سجل الأن",
                      isBold: false,
                      align: TextAlign.center,
                      fontSize:
                          MediaQuery.orientationOf(context) ==
                              Orientation.portrait
                          ? MediaQuery.sizeOf(context).width * 0.04
                          : MediaQuery.sizeOf(context).width * 0.02,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

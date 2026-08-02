import 'package:daftra/screens/login.dart';
import 'package:daftra/utils/label_textform.dart';
import 'package:daftra/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String passowrdText = '';
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
                    text: "انشاء حساب جديد",
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
                        ? MediaQuery.sizeOf(context).width * 0.025
                        : MediaQuery.sizeOf(context).width * 0.012,
                  ),
                  CustomText(
                    text: "أدخل بيانتك للبدء في ادارة دفترك",
                    isBold: false,
                    fontSize:
                        MediaQuery.orientationOf(context) ==
                            Orientation.portrait
                        ? MediaQuery.sizeOf(context).width * 0.04
                        : MediaQuery.sizeOf(context).width * 0.023,
                    color: Theme.of(context).colorScheme.onSurface,
                    align: TextAlign.center,
                  ),
                  SizedBox(
                    height:
                        MediaQuery.orientationOf(context) ==
                            Orientation.portrait
                        ? MediaQuery.sizeOf(context).width * 0.1
                        : MediaQuery.sizeOf(context).width * 0.03,
                  ),
                  Labeltextform(
                    text: "اسم المحل",
                    suffix: const Icon(Icons.store_mall_directory_rounded),
                    textform: "مثال: محل البقالة",
                    validator: (value) {
                      passowrdText = value!;
                      if (value.isEmpty) {
                        return "برجاء ادخال اسم المحل";
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
                    text: "رقم الهاتف",
                    suffix: const Icon(Icons.phone),
                    textform: "ادخل رقم الهاتف مثل 01012345678",
                    validator: (value) {
                      passowrdText = value!;
                      final RegExp phoneRegx = RegExp(r'^01[0125][0-9]{8}$');
                      if (value.isEmpty) {
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
                    suffix: const Icon(Icons.lock),
                    textform: "ادخل كلمة المرور يتكون من 8 حروف علي الاقل",
                    isObscure: true,
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
                  SizedBox(
                    height:
                        MediaQuery.orientationOf(context) ==
                            Orientation.portrait
                        ? MediaQuery.sizeOf(context).width * 0.05
                        : MediaQuery.sizeOf(context).width * 0.025,
                  ),
                  Labeltextform(
                    text: "تأكيد كلمة المرور",
                    suffix: const Icon(Icons.lock),
                    textform: "برجاء ادخال نفس كلمة المرور",
                    isObscure: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'برجاء ادخال كلمة المرور';
                      } else if (value != passowrdText) {
                        return 'برجاء ادخال نفس كلمة المرور';
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
                        Icon(
                          Icons.arrow_forward,
                          color: Theme.of(context).colorScheme.surface,
                          size: 20,
                        ),
                        CustomText(
                          text: "إنشاء حساب ",
                          isBold: true,
                          color: Theme.of(context).colorScheme.surface,
                          fontSize: 16,
                          align: TextAlign.center,
                        ),
                      ],
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
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const Login()),
                    ),
                    child: CustomText(
                      text: "لديك حساب بالفعل؟؟ تسجيل الدخول",
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

import 'package:daftra/widgets/customText.dart';
import 'package:daftra/widgets/customTextForm.dart';
import 'package:flutter/material.dart';

class Labeltextform extends StatelessWidget {
  final String text;
  final bool isBold;
  final double fontSize;
  final Widget suffix;
  final String textform;
  final String? Function(String?)? validator;
  final bool? isObscure;
  const Labeltextform({
    super.key,
    required this.text,
    required this.isBold,
    required this.fontSize,
    required this.suffix,
    required this.textform,
    this.validator,
    this.isObscure
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomText(
          text: text,
          fontSize: fontSize,
          isBold: isBold,
          color: Theme.of(context).colorScheme.onSurface,
          align: TextAlign.right,
        ),
        const SizedBox(height: 5),
        CustomTextform(text: textform, suffix: suffix, validator: validator,),
      ],
    );
  }
}

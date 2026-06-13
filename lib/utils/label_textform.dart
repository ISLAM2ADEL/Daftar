import 'package:daftra/widgets/custom_text.dart';
import 'package:daftra/widgets/custom_textform.dart';
import 'package:flutter/material.dart';

class Labeltextform extends StatelessWidget {
  final String text;
  final Widget suffix;
  final String textform;
  final String? Function(String?)? validator;
  final bool? isObscure;
  const Labeltextform({
    super.key,
    required this.text,
    required this.suffix,
    required this.textform,
    this.validator,
    this.isObscure,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomText(
          text: text,
          isBold: true,
          fontSize: MediaQuery.orientationOf(context) == Orientation.portrait
              ? MediaQuery.sizeOf(context).width * 0.03
              : MediaQuery.sizeOf(context).width * 0.02,
          color: Theme.of(context).colorScheme.onSurface,
          align: TextAlign.right,
        ),
        const SizedBox(height: 5),
        CustomTextform(text: textform, suffix: suffix, validator: validator),
      ],
    );
  }
}

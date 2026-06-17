import 'package:flutter/material.dart';

class CustomTextform extends StatelessWidget {
  final Widget suffix;
  final String text;
  final bool? isObscure;
  final bool isNumber;
  final String? Function(String?)? validator;

  const CustomTextform({
    super.key,
    required this.suffix,
    required this.text,
    this.validator,
    this.isObscure,
    this.isNumber = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.right,
      obscureText: isObscure ?? false,
      keyboardType: isNumber ? TextInputType.number : null,
      decoration: InputDecoration(
        hintText: text.toString(),
        hintStyle: TextStyle(
          fontFamily: 'ARIAL_0',
          fontSize: MediaQuery.orientationOf(context) == Orientation.portrait
              ? MediaQuery.sizeOf(context).width * 0.03
              : MediaQuery.sizeOf(context).width * 0.015,
          color: Theme.of(context).inputDecorationTheme.hintStyle?.color,
        ),
        suffixIcon: suffix,
      ),
      validator: validator!,
    );
  }
}

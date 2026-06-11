import 'package:flutter/material.dart';

class CustomTextform extends StatelessWidget {
  final Widget suffix;
  final String text;
  final String? Function(String?)? validator;
  const CustomTextform({
    super.key,
    required this.suffix,
    required this.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.right,
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

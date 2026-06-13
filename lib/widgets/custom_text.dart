import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final bool isBold;
  final Color? color;
  final double fontSize;
  final TextAlign align;
  const CustomText({
    super.key,
    required this.text,
    required this.isBold,
    this.color,
    required this.fontSize,
    required this.align,
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'IBMPlexSans',
        fontWeight: isBold ? FontWeight.bold : null,
        fontSize: fontSize,
        color: color ?? Theme.of(context).colorScheme.onSurface,
      ),
      textAlign: align,
    );
  }
}

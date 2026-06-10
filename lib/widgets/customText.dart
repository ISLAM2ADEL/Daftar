import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final bool isBold;
  final int colours;
  final double fontSize;
  final TextAlign align;
  const CustomText({
    super.key,
    required this.text,
    required this.isBold,
    required this.colours,
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
        color: Color(colours),
      ),
      textAlign: align,
    );
  }
}

import 'package:flutter/material.dart';

class CustomTextform extends StatelessWidget {
  final Widget suffix;
  final String text;
  const CustomTextform({super.key, required this.suffix, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.left,
      decoration: InputDecoration(
        hintText: text.toString(),
        hintStyle: TextStyle(
            fontFamily: 'ARIAL_0',
            fontSize: MediaQuery.orientationOf(context) == Orientation.portrait
                ? MediaQuery.sizeOf(context).width * 0.03
                : MediaQuery.sizeOf(context).width * 0.015,
            color: Theme.of(context).inputDecorationTheme.hintStyle?.color),
        suffixIcon: suffix,
      ),
    );
  }
}

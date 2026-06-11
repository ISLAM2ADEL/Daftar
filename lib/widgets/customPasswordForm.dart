import 'package:flutter/material.dart';

class CustomPasswordform extends StatelessWidget {
  final String text;
  const CustomPasswordform({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.left,
      obscureText: true,
      decoration: InputDecoration(
        hintText: text.toString(),
        hintStyle: TextStyle(
          fontFamily: 'ARIAL_0',
          fontSize: MediaQuery.orientationOf(context) == Orientation.portrait
              ? MediaQuery.sizeOf(context).width * 0.03
              : MediaQuery.sizeOf(context).width * 0.015,
          color: Theme.of(context).inputDecorationTheme.hintStyle?.color,
        ),
        prefixIcon: const Icon(Icons.remove_red_eye),
        suffixIcon: const Icon(Icons.lock_clock_rounded),
      ),
    );
  }
}

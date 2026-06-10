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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE2E2E2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF4A80F0)),
        ),
        hintText: text.toString(),
        hintStyle: TextStyle(
          fontFamily: 'ARIAL_0',
          fontSize: MediaQuery.orientationOf(context) == Orientation.portrait
              ? MediaQuery.sizeOf(context).width * 0.03
              : MediaQuery.sizeOf(context).width * 0.015,
          color: const Color(0xFF9FA3A9),
        ),
        prefixIcon: const Icon(Icons.remove_red_eye),
        suffixIcon: const Icon(Icons.lock_clock_rounded),
        suffixIconColor: const Color(0xFF3A4550),
        prefixIconColor: const Color(0xFF3A4550),
      ),
    );
  }
}

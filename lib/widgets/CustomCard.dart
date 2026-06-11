import 'package:daftra/widgets/customListTile.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomCard extends StatelessWidget {
  final Color? color;
  final Color? textColor;
  final Widget suffix;
  final String text;
  final void Function()? tapped;
  const CustomCard({
    super.key,
    this.color,
    this.textColor,
    required this.text,
    required this.suffix,
    required this.tapped,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      color: color ?? Theme.of(context).colorScheme.surface,
      margin: const EdgeInsets.all(15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: CustomListTile(
        color: textColor,
        text: text,
        suffix: suffix,
        tapped: tapped,
      ),
    );
  }
}

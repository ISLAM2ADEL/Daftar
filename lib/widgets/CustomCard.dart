import 'package:daftra/widgets/CustomListTile.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomCard extends StatelessWidget {
  final int colours;
  final int textcolours;
  final Widget suffix;
  final String text;
  final void Function()? tapped;
  const CustomCard({
    super.key,
    required this.colours,
    required this.textcolours,
    required this.text,
    required this.suffix,
    required this.tapped,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(colours),
      margin: const EdgeInsets.all(15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: CustomListTile(
        colours: textcolours,
        text: text,
        suffix: suffix,
        tapped: tapped,
      ),
    );
  }
}

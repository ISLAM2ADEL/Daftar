import 'package:flutter/material.dart';


class CustomListTile extends StatelessWidget {
  final Color? color;
  final Widget suffix;
  final String text;
  final void Function()? tapped;
  const CustomListTile({
    super.key,
    this.color,
    required this.text,
    required this.suffix,
    required this.tapped,
  });
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: tapped,
      trailing: suffix,
      leading: Text(
        text,
        style: TextStyle(
          fontFamily: 'ARIAL_0',
          fontSize: MediaQuery.orientationOf(context) == Orientation.portrait
              ? MediaQuery.sizeOf(context).width * 0.04
              : MediaQuery.sizeOf(context).width * 0.02,
          color: color ?? Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}

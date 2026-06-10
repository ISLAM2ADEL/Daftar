import 'package:daftra/widgets/CustomText.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.text,
    this.onLeadingPressed,
    this.leadingicon,
    this.trailingicon,
  });
  final String text;
  final IconData? leadingicon;
  final IconData? trailingicon;
  final void Function()? onLeadingPressed;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Builder(
        builder: (context) => IconButton(
          color: const Color(0xFF0F172A),
          icon: Icon(leadingicon),
          onPressed: () {
            onLeadingPressed!();
          },
        ),
      ),
      title: Center(
        child: CustomText(
          text: text,
          isBold: true,
          colours: 0xFF0F172A,
          fontSize: 20,
          align: TextAlign.center,
        ),
      ),
      backgroundColor: const Color(0xFFFFFFFF),
      actions: [
        IconButton(
          icon:  Icon(trailingicon),
          color: const Color(0xFF0F172A),
          onPressed: () {
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

import 'package:daftra/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.text,
    this.onLeadingPressed,
    this.leadingicon,
    this.trailingicon,
    this.onTrailingPressed,
  });
  final String text;
  final IconData? leadingicon;
  final IconData? trailingicon;
  final void Function()? onLeadingPressed;
  final void Function()? onTrailingPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // Bug fix #2: leading shows leadingicon calling onLeadingPressed
      leading: leadingicon != null
          ? IconButton(
              icon: Icon(leadingicon),
              onPressed: onLeadingPressed,
            )
          : null,
      automaticallyImplyLeading: false,
      title: Center(
        child: CustomText(
          text: text,
          isBold: true,
          color: Theme.of(context).appBarTheme.titleTextStyle?.color,
          fontSize: 20,
          align: TextAlign.center,
        ),
      ),
      // Bug fix #2: actions shows trailingicon calling onTrailingPressed
      actions: [
        if (trailingicon != null)
          IconButton(
            icon: Icon(trailingicon),
            onPressed: onTrailingPressed,
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

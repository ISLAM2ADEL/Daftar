import 'package:daftra/widgets/customText.dart';
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
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(leadingicon),
          onPressed: () {
            if (onLeadingPressed != null) onLeadingPressed!();
          },
        ),
      ),
      title: Center(
        child: CustomText(
          text: text,
          isBold: true,
          color: Theme.of(context).appBarTheme.titleTextStyle?.color,
          fontSize: 20,
          align: TextAlign.center,
        ),
      ),
      actions: [IconButton(icon: Icon(trailingicon), onPressed: () {})],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

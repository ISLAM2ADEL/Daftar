import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  /// Index of the currently active tab.
  /// 0 = الإعدادات (Settings), 1 = العملاء (Customers), 2 = الرئيسية (Home)
  final int currentIndex;

  /// Called with the tapped tab index when the user taps a tab.
  final void Function(int) onTap;

  const CustomBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = Theme.of(context).colorScheme.secondary;

    return BottomAppBar(
      color: Theme.of(context).colorScheme.surface,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildItem(
            context: context,
            icon: Icons.settings_outlined,
            label: 'الإعدادات',
            index: 0,
            activeColor: activeColor,
          ),
          _buildItem(
            context: context,
            icon: Icons.people_outline,
            label: 'العملاء',
            index: 1,
            activeColor: activeColor,
          ),
          _buildItem(
            context: context,
            icon: Icons.home,
            label: 'الرئيسية',
            index: 2,
            activeColor: activeColor,
          ),
        ],
      ),
    );
  }

  Widget _buildItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required int index,
    required Color activeColor,
  }) {
    final isActive = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? activeColor : null,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white),
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

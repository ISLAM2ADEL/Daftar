import 'package:daftra/cubits/settings_cubit.dart';
import 'package:daftra/cubits/settings_state.dart';
import 'package:daftra/screens/customers.dart';
import 'package:daftra/screens/home.dart';
import 'package:daftra/screens/login.dart';
import 'package:daftra/widgets/Custom_card.dart';
import 'package:daftra/widgets/custom_appbar.dart';
import 'package:daftra/widgets/custom_buttonbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _navigate(BuildContext context, int index) {
    if (index == 0) return; // already here
    if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Home()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const CustomersScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: 'الإعدادات'),
      body: SafeArea(
        child: Column(
          children: [
            const Divider(color: Colors.grey),
            const SizedBox(height: 8),

            // ── Appearance ────────────────────────────────────────────────
            BlocBuilder<SettingsCubit, SettingsState>(
              builder: (context, state) {
                final isDark = state.themeMode == ThemeMode.dark;
                return CustomCard(
                  text: 'المظهر',
                  suffix: Switch(
                    value: isDark,
                    activeThumbColor: Theme.of(context).colorScheme.primary,
                    onChanged: (_) =>
                        context.read<SettingsCubit>().toggleTheme(),
                  ),
                  tapped: () => context.read<SettingsCubit>().toggleTheme(),
                );
              },
            ),

            // ── App Info ──────────────────────────────────────────────────
            CustomCard(
              text: 'معلومات التطبيق',
              suffix: const Icon(Icons.info_outline),
              tapped: () {
                showAboutDialog(
                  context: context,
                  applicationName: 'دفتر Daftra',
                  applicationVersion: '1.0.0',
                  applicationLegalese: '© 2024 Daftra',
                  children: const [
                    SizedBox(height: 12),
                    Text(
                      'تطبيق دفتر Daftra لإدارة الديون والمدفوعات لأصحاب المحلات التجارية.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              },
            ),

            // ── Backup ────────────────────────────────────────────────────
            CustomCard(
              text: 'النسخ الاحتياطي',
              suffix: const Icon(Icons.backup_outlined),
              tapped: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('قريباً'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),

            // ── Logout ────────────────────────────────────────────────────
            CustomCard(
              text: 'تسجيل الخروج',
              textColor: Theme.of(context).colorScheme.secondary,
              suffix: Icon(
                Icons.logout,
                color: Theme.of(context).colorScheme.secondary,
              ),
              tapped: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const Login()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: 0,
        onTap: (i) => _navigate(context, i),
      ),
    );
  }
}

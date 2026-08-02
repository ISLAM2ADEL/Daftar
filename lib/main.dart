import 'package:daftra/cubits/customers_cubit.dart';
import 'package:daftra/cubits/settings_cubit.dart';
import 'package:daftra/cubits/settings_state.dart';
import 'package:daftra/data/customer_repository.dart';
import 'package:daftra/data/hive_boxes.dart';
import 'package:daftra/data/transaction_repository.dart';
import 'package:daftra/screens/login.dart';
import 'package:daftra/Themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final customerRepo = CustomerRepository();
    final transactionRepo = TransactionRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider<CustomersCubit>(
          create: (_) => CustomersCubit(
            customerRepository: customerRepo,
            transactionRepository: transactionRepo,
          )..loadCustomers(),
        ),
        BlocProvider<SettingsCubit>(
          create: (_) => SettingsCubit(),
        ),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, settingsState) {
          return MaterialApp(
            title: 'دفتر Daftra',
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            themeMode: settingsState.themeMode,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('en', 'US'), Locale('ar')],
            locale: const Locale('ar'),
            home: const Login(),
          );
        },
      ),
    );
  }
}

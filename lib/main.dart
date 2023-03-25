import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fwheirs/base/theme/theme_constants.dart';
import 'package:fwheirs/base/theme/theme_manager.dart';
import 'package:provider/provider.dart';

import 'app/view/splash_screen.dart';
import 'app/view_models/auth_providers/auth_provider.dart';
import 'app/view_models/investment_providers/investment_provider.dart';
import 'app/view_models/profile_providers/profile_provider.dart';
import 'app/view_models/referrals_providers.dart';
import 'dependency_injection/locator.dart';
import 'local_storage/local_db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new MyHttpOverrides();
  await AppDependencies.register();
  await AppDataBaseService.startService();

  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

ThemeManager _themeManager = ThemeManager();

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeManager()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => InvestmentProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => ReferralsProvider()),
      ],
      child: Consumer<ThemeManager>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            // initialRoute: "/",
            // routes: AppPages.routes,
            title: "FWHeirs",
            home: SplashScreen(),
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeProvider.themeMode,
          );
        },
      ),
    );
  }
}

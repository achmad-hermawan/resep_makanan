import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'providers/favorite_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/translate_provider.dart';
import 'screens/home_screen.dart';
import 'screens/favorite_screen.dart';
import 'screens/main_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';

// Inisialisasi Firebase sebelum aplikasi dijalankan. Wajib untuk fungsi-fungsi autentikasi.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Menyambungkan ke Firebase untuk fitur login/register.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    // Menyediakan banyak state global (FavoriteProvider dan ThemeProvider).
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => TranslateProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context); // Mengubah tema aplikasi secara dinamis (light/dark).

    return MaterialApp(
      title: 'Resep Makanan',
      themeMode: themeProvider.themeMode,

      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.grey,
          brightness: Brightness.light,
        ),
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber,
          brightness: Brightness.dark,
        ),
      ),

      home: const MainScreen(),
      routes: {
        '/settings': (context) => const SettingsScreen(),
        '/login': (context) => const LoginScreen(),     // halaman login
        '/register': (context) => const RegisterScreen(), // halaman daftar
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/favorite_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/home_screen.dart';
import 'screens/favorite_screen.dart';
import 'screens/main_screen.dart'; // karena sudah dipisah

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

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
          seedColor: Colors.grey, // warna aksen netral
          brightness: Brightness.light,
        ),
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber, // atau sesuai selera kamu
          brightness: Brightness.dark,
        ),
      ),

      home: const MainScreen(),
    );
  }
}

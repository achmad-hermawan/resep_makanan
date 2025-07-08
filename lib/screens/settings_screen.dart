import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/translate_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengakses provider untuk tema (gelap/terang) dan penerjemah
    final themeProvider = Provider.of<ThemeProvider>(context);
    final translateProvider = Provider.of<TranslateProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Setelan"), // Judul halaman setelan
      ),
      body: ListView(
        children: [
          // Pengaturan untuk mengganti tema aplikasi (gelap/terang)
          SwitchListTile(
            title: const Text("Mode Gelap"),
            value: themeProvider.isDarkMode,
            onChanged: (val) => themeProvider.toggleTheme(val),
          ),
          // Pengaturan untuk mengaktifkan/menonaktifkan terjemahan otomatis
          SwitchListTile(
            title: const Text("Terjemahkan ke Bahasa Indonesia"),
            value: translateProvider.isTranslate,
            onChanged: (val) => translateProvider.toggleTranslate(val),
          ),
        ],
      ),
    );
  }
}

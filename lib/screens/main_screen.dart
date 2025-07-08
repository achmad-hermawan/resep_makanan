import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import 'home_screen.dart';
import 'favorite_screen.dart';
import 'login_screen.dart';
import 'settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const FavoriteScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Resep Makanan"),
        actions: [
          // Pantau status login user secara real-time menggunakan stream dari Firebase Authentication
          StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              final user = snapshot.data;

              return PopupMenuButton<String>(
                //Menampilkan avatar dengan huruf awal email jika sudah login. Jika belum, tampilkan ikon login.
                icon: user != null
                    ? CircleAvatar(
                  backgroundColor: Colors.grey.shade300,
                  child: Text(
                    user.email![0].toUpperCase(),
                    style: const TextStyle(color: Colors.black),
                  ),
                )
                    : const Icon(Icons.login),

                // Menangani navigasi berdasarkan opsi yang dipilih dari menu popup.
                onSelected: (value) {
                  if (value == 'settings') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SettingsScreen()),
                    );
                  } else if (value == 'login') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    );
                  } else if (value == 'logout') {
                    FirebaseAuth.instance.signOut();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Berhasil logout')),
                    );
                  }
                },

                // Menampilkan opsi menu yang relevan tergantung status login: email, setelan, logout vs login, setelan.
                itemBuilder: (context) => [
                  if (user != null) ...[
                    PopupMenuItem(
                      value: 'email',
                      enabled: false,
                      child: Text(user.email ?? ''),
                    ),
                    const PopupMenuItem(
                      value: 'settings',
                      child: Text('Setelan'),
                    ),
                    const PopupMenuItem(
                      value: 'logout',
                      child: Text('Logout'),
                    ),
                  ] else ...[
                    const PopupMenuItem(
                      value: 'login',
                      child: Text('Login / Masuk'),
                    ),
                    const PopupMenuItem(
                      value: 'settings',
                      child: Text('Setelan'),
                    ),
                  ]
                ],
              );
            },
          ),
        ],
      ),

      // Menampilkan halaman aktif sesuai tab yang dipilih di bottom navigation.
      body: _screens[_currentIndex],
      // Navigasi utama antara halaman Cari (HomeScreen) dan Favorit (FavoriteScreen).
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Cari',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorit',
          ),
        ],
      ),
    );
  }
}

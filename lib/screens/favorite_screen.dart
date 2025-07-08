import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../providers/favorite_provider.dart';
import '../widgets/meal_item.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser; // Cek status login
    final favorites = Provider.of<FavoriteProvider>(context).favorites; // Ambil daftar favorit dari provider

    return Padding(
      padding: const EdgeInsets.all(16),
      child: user == null
      // Jika belum login, tampilkan pesan agar login dulu
          ? const Center(
        child: Text(
          'Silakan login untuk melihat resep favorit Anda.',
          style: TextStyle(fontSize: 16),
        ),
      )
          : favorites.isEmpty
      // Jika login tapi belum ada favorit, tampilkan pesan
          ? const Center(
        child: Text(
          'Belum ada resep favorit.',
          style: TextStyle(fontSize: 16),
        ),
      )
      // Jika ada favorit, tampilkan daftar resep favorit
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          return MealItem(meal: favorites[index]);
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorite_provider.dart';
import '../widgets/meal_item.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<FavoriteProvider>(context).favorites;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: favorites.isEmpty
            ? const Center(child: Text('Belum ada resep favorit.'))
            : ListView.builder(
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            return MealItem(meal: favorites[index]);
          },
        ),
      ),
    );
  }
}

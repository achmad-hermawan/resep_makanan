import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/meal_model.dart';
import '../providers/favorite_provider.dart';

class DetailScreen extends StatelessWidget {
  final Meal meal;
  const DetailScreen({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final isFavorite = favoriteProvider.isFavorite(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.name),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () {
              favoriteProvider.toggleFavorite(meal);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tambahkan Hero di sini
            Hero(
              tag: meal.name,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  meal.image,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Instruksi Memasak:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              meal.instructions,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

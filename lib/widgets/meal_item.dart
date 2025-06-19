import 'package:flutter/material.dart';
import '../models/meal_model.dart';
import '../screens/detail_screen.dart';

class MealItem extends StatelessWidget {
  final Meal meal;
  const MealItem({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DetailScreen(meal: meal)),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // Animasi hero
            Hero(
              tag: meal.name, //
              child: Image.network(
                meal.image,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.black.withOpacity(0.5),
              padding: const EdgeInsets.all(8),
              child: Text(
                meal.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

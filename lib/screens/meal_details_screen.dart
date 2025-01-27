import 'package:flutter/material.dart';
import '../data/models/diet_plan.dart';

class MealDetailsScreen extends StatelessWidget {
  final Meal meal;

  const MealDetailsScreen({Key? key, required this.meal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.name),
        backgroundColor: Colors.green[400],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMealHeader(),
            const SizedBox(height: 20),
            _buildMealNotes(),
            const SizedBox(height: 20),
            _buildFoodList(),
          ],
        ),
      ),
    );
  }

  Widget _buildMealHeader() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              meal.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Scheduled for ${meal.time}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMealNotes() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Notes',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              meal.notes,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodList() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Food Items',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...meal.items
                .expand((item) =>
                    item.alternatives.map((alt) => _buildFoodItem(alt)))
                .toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodItem(Alternative alternative) {
    final food = alternative.food;
    final macros = food.macrosPer100g;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  food.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Category: ${food.category}',
                  style: const TextStyle(color: Colors.grey),
                ),
                Text(
                  'Serving: ${alternative.serving}${food.defaultServing}g',
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Text(
                  'Per 100g: ${macros.calories}cal, ${macros.protein}g protein, '
                  '${macros.carbs}g carbs, ${macros.fat}g fat',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

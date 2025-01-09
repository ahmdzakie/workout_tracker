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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Time: ${meal.time}', 
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            Text('Food Items:', 
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            ...meal.items.map((item) => _buildFoodAlternatives(item)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodAlternatives(MealItem item) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: item.alternatives.length,
        itemBuilder: (context, index) {
          final alternative = item.alternatives[index];
          return ListTile(
            title: Text('Food ID: ${alternative.foodId}'),
            subtitle: Text('Serving: ${alternative.serving}g'),
          );
        },
      ),
    );
  }
}

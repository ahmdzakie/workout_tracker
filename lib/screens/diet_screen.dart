import 'package:flutter/material.dart';
import 'meal_details_screen.dart';
import '../data/models/diet_plan.dart';
import '../data/repositories/diet_repository.dart';
import '../data/repositories/mock_diet_repository.dart';

class DietScreen extends StatefulWidget {
  const DietScreen({Key? key}) : super(key: key);
  
  @override
  _DietScreenState createState() => _DietScreenState();
}

class _DietScreenState extends State<DietScreen> {
  // Use MockDietRepository for development/testing
  final DietRepository _dietRepository = MockDietRepository();
  late Future<DietPlan> _dietPlan;

  @override
  void initState() {
    super.initState();
    _dietPlan = _dietRepository.getDietPlan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DietPlan>(
        future: _dietPlan,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CustomScrollView(
              slivers: [
                _buildSliverAppBar(snapshot.data!),
                SliverToBoxAdapter(
                  child: _buildMacroStats(snapshot.data!),
                ),
                _buildMealsList(snapshot.data!),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildSliverAppBar(DietPlan plan) {
    return SliverAppBar(
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(plan.name),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor.withOpacity(0.7),
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Text(
                  '${plan.targetCalories}',
                  style: const TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Daily Calories',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMacroStats(DietPlan plan) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildMacroCard('Protein', plan.targetMacros.protein, Colors.red),
          _buildMacroCard('Carbs', plan.targetMacros.carbs, Colors.green),
          _buildMacroCard('Fats', plan.targetMacros.fats, Colors.blue),
        ],
      ),
    );
  }

  Widget _buildMacroCard(String title, int value, Color color) {
    return Card(
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(16),
        width: 100,
        child: Column(
          children: [
            Text(
              '$value g',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMealsList(DietPlan plan) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final meal = plan.days[0].meals[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 2,
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getMealIcon(meal.name),
                  color: Theme.of(context).primaryColor,
                ),
              ),
              title: Text(
                meal.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                meal.time,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MealDetailsScreen(meal: meal),
                  ),
                );
              },
            ),
          );
        },
        childCount: plan.days[0].meals.length,
      ),
    );
  }

  IconData _getMealIcon(String mealName) {
    switch (mealName.toLowerCase()) {
      case 'breakfast':
        return Icons.breakfast_dining;
      case 'lunch':
        return Icons.lunch_dining;
      case 'dinner':
        return Icons.dinner_dining;
      case 'snack':
        return Icons.restaurant_menu;
      default:
        return Icons.food_bank;
    }
  }
}
import 'package:flutter/material.dart';
import 'meal_details_screen.dart';
import '../data/models/diet_plan.dart';
import '../data/repositories/diet_repository.dart';
import '../data/repositories/mock_diet_repository.dart';  // For development/testing

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
    return FutureBuilder<DietPlan>(
      future: _dietPlan,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            child: Column(
              children: [
                _buildDietHeader(snapshot.data!),
                _buildMealsList(snapshot.data!),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildDietHeader(DietPlan plan) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(plan.name, style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 8),
            Text('Target Calories: ${plan.targetCalories}'),
            Text('Protein: ${plan.targetMacros.protein}g'),
            Text('Carbs: ${plan.targetMacros.carbs}g'),
            Text('Fats: ${plan.targetMacros.fats}g'),
          ],
        ),
      ),
    );
  }

  Widget _buildMealsList(DietPlan plan) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: plan.days[0].meals.length,
      itemBuilder: (context, index) {
        final meal = plan.days[0].meals[index];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            title: Text(meal.name),
            subtitle: Text(meal.time),
            trailing: Icon(Icons.arrow_forward_ios),
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
    );
  }
}

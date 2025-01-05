import '../models/diet_plan.dart';
import 'diet_repository.dart';
class MockDietRepository implements DietRepository {
  final DietPlan _mockDietPlan = DietPlan(
    id: 123,
    name: "Weight Loss Plan",
    targetCalories: 2000,
    targetMacros: MacroNutrients(
      protein: 150,
      carbs: 200,
      fats: 67,
    ),
    days: [
      DietDay(
        meals: [
          Meal(
            name: "Breakfast",
            time: "08:00",
            items: [
              MealItem(
                alternatives: [
                  FoodAlternative(
                    foodId: 1,
                    serving: 150,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );

  @override
  Future<DietPlan> getDietPlan() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _mockDietPlan;
  }

  @override
  Future<DietPlan> getDietPlanById(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockDietPlan;
  }
}



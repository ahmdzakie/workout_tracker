class DietPlan {
  final int id;
  final String name;
  final int targetCalories;
  final MacroNutrients targetMacros;
  final List<DietDay> days;

  DietPlan({
    required this.id,
    required this.name,
    required this.targetCalories,
    required this.targetMacros,
    required this.days,
  });

  factory DietPlan.fromJson(Map<String, dynamic> json) {
    return DietPlan(
      id: json['id'],
      name: json['name'],
      targetCalories: json['targetCalories'],
      targetMacros: MacroNutrients.fromJson(json['targetMacros']),
      days: (json['days'] as List).map((day) => DietDay.fromJson(day)).toList(),
    );
  }
}

class MacroNutrients {
  final int protein;
  final int carbs;
  final int fats;

  MacroNutrients({
    required this.protein,
    required this.carbs,
    required this.fats,
  });

  factory MacroNutrients.fromJson(Map<String, dynamic> json) {
    return MacroNutrients(
      protein: json['protein'],
      carbs: json['carbs'],
      fats: json['fats'],
    );
  }
}

class DietDay {
  final List<Meal> meals;

  DietDay({required this.meals});

  factory DietDay.fromJson(Map<String, dynamic> json) {
    return DietDay(
      meals: (json['meals'] as List).map((meal) => Meal.fromJson(meal)).toList(),
    );
  }
}

class Meal {
  final String name;
  final String time;
  final List<MealItem> items;

  Meal({
    required this.name,
    required this.time,
    required this.items,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      name: json['name'],
      time: json['time'],
      items: (json['items'] as List).map((item) => MealItem.fromJson(item)).toList(),
    );
  }
}

class MealItem {
  final List<FoodAlternative> alternatives;

  MealItem({required this.alternatives});

  factory MealItem.fromJson(Map<String, dynamic> json) {
    return MealItem(
      alternatives: (json['alternatives'] as List)
          .map((alt) => FoodAlternative.fromJson(alt))
          .toList(),
    );
  }
}

class FoodAlternative {
  final int foodId;
  final int serving;

  FoodAlternative({required this.foodId, required this.serving});

  factory FoodAlternative.fromJson(Map<String, dynamic> json) {
    return FoodAlternative(
      foodId: json['food_id'],
      serving: json['serving'],
    );
  }
}

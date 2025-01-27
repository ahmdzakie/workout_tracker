class DietPlan {
  final int id;
  final String name;
  final int targetCalories;

  final int targetCarbs;
  final int targetFat;
  final int targetProtein;
  final List<Day> days;

  DietPlan({
    required this.id,
    required this.name,
    required this.targetCalories,
    required this.targetCarbs,
    required this.targetFat,
    required this.targetProtein,
    required this.days,
  });

  factory DietPlan.fromJson(Map<String, dynamic> json) {
    return DietPlan(
      id: json['id'],
      name: json['name'],
      targetCalories: json['targetCalories'],
      targetCarbs: json['targetCarbs'],
      targetFat: json['targetFat'],
      targetProtein: json['targetProtein'],
      days: (json['days'] as List).map((day) => Day.fromJson(day)).toList(),
    );
  }
}

class Day {
  final int id;
  final String notes;
  final List<Meal> meals;

  Day({
    required this.id,
    required this.notes,
    required this.meals,
  });

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      id: json['id'],
      notes: json['notes'],
      meals:
          (json['meals'] as List).map((meal) => Meal.fromJson(meal)).toList(),
    );
  }
}

class Meal {
  final int id;
  final String name;
  final String notes;
  final String time;
  final List<MealItem> items;

  Meal({
    required this.id,
    required this.name,
    required this.notes,
    required this.time,
    required this.items,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['id'],
      name: json['name'],
      notes: json['notes'],
      time: json['time'],
      items: (json['items'] as List)
          .map((item) => MealItem.fromJson(item))
          .toList(),
    );
  }
}

class MealItem {
  final int id;
  final int mealId;
  final List<Alternative> alternatives;

  MealItem({
    required this.id,
    required this.mealId,
    required this.alternatives,
  });

  factory MealItem.fromJson(Map<String, dynamic> json) {
    return MealItem(
      id: json['id'],
      mealId: json['meal_id'],
      alternatives: (json['alternatives'] as List)
          .map((alt) => Alternative.fromJson(alt))
          .toList(),
    );
  }
}

class Alternative {
  final int id;
  final int foodId;
  final double serving;
  final Food food;

  Alternative({
    required this.id,
    required this.foodId,
    required this.serving,
    required this.food,
  });

  factory Alternative.fromJson(Map<String, dynamic> json) {
    return Alternative(
      id: json['id'],
      foodId: json['food_id'],
      serving: json['serving'],
      food: Food.fromJson(json['food']),
    );
  }
}

class Food {
  final int id;
  final String name;
  final String category;
  final double defaultServing;
  final MacrosPer100g macrosPer100g;
  final List<String> tags;

  Food({
    required this.id,
    required this.name,
    required this.category,
    required this.defaultServing,
    required this.macrosPer100g,
    required this.tags,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      defaultServing: json['default_serving'],
      macrosPer100g: MacrosPer100g.fromJson(json['macrosPer100g']),
      tags: (json['tags'] as List).map((tag) => tag as String).toList(),
    );
  }
}

class MacrosPer100g {
  final int calories;
  final double carbs;
  final double fat;
  final double protein;

  MacrosPer100g({
    required this.calories,
    required this.carbs,
    required this.fat,
    required this.protein,
  });

  factory MacrosPer100g.fromJson(Map<String, dynamic> json) {
    return MacrosPer100g(
      calories: json['calories'],
      carbs: json['carbs'],
      fat: json['fat'],
      protein: json['protein'],
    );
  }
}

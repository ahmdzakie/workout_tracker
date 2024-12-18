enum Category { Strength, Cardio, Flexibility }
enum MuscleGroup { UpperBody, LowerBody, Core }
enum Equipment { Bodyweight, Dumbbells, Machines }
enum SkillLevel { Beginner, Intermediate, Advanced }

class Workout {
  final String id;
  final String name;
  final String description;
  final List<Exercise> exercises;
  final DateTime date;
  final String dayOfWeek;

  Workout({
    required this.id,
    required this.name,
    required this.description,
    required this.exercises,
    required this.date,
    required this.dayOfWeek,
  });

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      exercises: (json['exercises'] as List)
          .map((e) => Exercise.fromJson(e))
          .toList(),
      date: DateTime.parse(json['date']),
      dayOfWeek: json['dayOfWeek'],
    );
  }
}

class Exercise {
  final String name;
  final int sets;
  final int reps;
  final String intensity;
  final String weight;
  final String notes;
  final String imageUrl;
  final int restTime;
  final Category category;
  final MuscleGroup muscleGroup;
  final Equipment equipment;
  final SkillLevel skillLevel;
  final String description;

  Exercise({
    required this.name,
    required this.sets,
    required this.reps,
    required this.intensity,
    required this.weight,
    required this.category,
    required this.muscleGroup,
    required this.equipment,
    required this.skillLevel,
    this.notes = '',
    this.imageUrl = '',
    this.restTime = 60,
    required this.description,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      name: json['name'],
      sets: json['sets'],
      reps: json['reps'],
      intensity: json['intensity'],
      weight: json['weight'],
      category: json['category'],
      muscleGroup: json['muscleGroup'],
      equipment: json['equipment'],
      skillLevel: json['skillLevel'],
      notes: json['notes'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      restTime: json['restTime'] ?? 60,
      description: json['description'],
    );
  }

// No imports needed for this file as it's a pure model class
}

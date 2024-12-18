enum Category { Strength, Cardio, Flexibility }
enum MuscleGroup { UpperBody, LowerBody, Core }
enum Equipment { Bodyweight, Dumbbells, Machines }
enum SkillLevel { Beginner, Intermediate, Advanced }

class Workout {
  final String name;
  final Map<String, List<Exercise>> weeklySchedule;

  Workout({
    required this.name,
    required this.weeklySchedule,
  });
}

class Exercise {
  final String name;
  final int sets;
  final int reps;
  final String intensity;
  final Category category;
  final MuscleGroup muscleGroup;
  final Equipment equipment;
  final SkillLevel skillLevel;
  final String description;
  final String? notes;

  Exercise({
    required this.name,
    required this.sets,
    required this.reps,
    required this.intensity,
    required this.category,
    required this.muscleGroup,
    required this.equipment,
    required this.skillLevel,
    required this.description,
    this.notes,
  });
}

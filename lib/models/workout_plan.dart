class WorkoutPlan {
  final int id;
  final String name;
  final String description;
  final DayPlan monday;
  final DayPlan tuesday;
  final DayPlan wednesday;
  final DayPlan thursday;
  final DayPlan friday;
  final DayPlan saturday;
  final DayPlan sunday;

  WorkoutPlan({
    required this.id,
    required this.name,
    required this.description,
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
  });

  factory WorkoutPlan.fromJson(Map<String, dynamic> json) {
    return WorkoutPlan(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      monday: DayPlan.fromJson(json['monday'], 'Monday'),
      tuesday: DayPlan.fromJson(json['tuesday'], 'Tuesday'),
      wednesday: DayPlan.fromJson(json['wednesday'], 'Wednesday'),
      thursday: DayPlan.fromJson(json['thursday'], 'Thursday'),
      friday: DayPlan.fromJson(json['friday'], 'Friday'),
      saturday: DayPlan.fromJson(json['saturday'], 'Saturday'),
      sunday: DayPlan.fromJson(json['sunday'], 'Sunday'),
    );
  }

  List<DayPlan> getAllPlanDays() {
    return [
      monday,
      tuesday,
      wednesday,
      thursday,
      friday,
      saturday,
      sunday,
    ];
  }
}

class DayPlan {
  final List<Exercise> exercises;
  final String name;

  DayPlan({required this.exercises, required this.name});

  factory DayPlan.fromJson(Map<String, dynamic> json, String name) {
    return DayPlan(
      exercises: (json['exercises'] as List)
          .map((e) => Exercise.fromJson(e))
          .toList(),
      name: name,
    );
  }
}

class Exercise {
  final int workoutId;
  final int sets;
  final int reps;
  final String technique;
  final int rpe;
  final String notes;
  final int restTime;

  Exercise({
    required this.workoutId,
    required this.sets,
    required this.reps,
    required this.technique,
    required this.rpe,
    required this.notes,
    required this.restTime,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      workoutId: json['workoutId'],
      sets: json['sets'],
      reps: json['reps'],
      technique: json['technique'],
      rpe: 3, // TODO: fix this later in the BE
      notes: json['notes'],
      restTime: json['restTime'],
    );
  }
}

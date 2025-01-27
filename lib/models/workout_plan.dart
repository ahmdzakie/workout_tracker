class WorkoutPlan {
  final int id;
  final String name;
  final String description;
  final String startDate;
  final String endDate;
  final String status;
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
    required this.startDate,
    required this.endDate,
    required this.status,
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
      startDate: json['startDate'],
      endDate: json['endDate'],
      status: json['status'],
      monday: DayPlan.fromJson(json['monday']),
      tuesday: DayPlan.fromJson(json['tuesday']),
      wednesday: DayPlan.fromJson(json['wednesday']),
      thursday: DayPlan.fromJson(json['thursday']),
      friday: DayPlan.fromJson(json['friday']),
      saturday: DayPlan.fromJson(json['saturday']),
      sunday: DayPlan.fromJson(json['sunday']),
    );
  }

  List<DayPlan> getAllPlanDays() {
    return [monday, tuesday, wednesday, thursday, friday, saturday, sunday];
  }
}

class DayPlan {
  final List<Exercise> exercises;

  DayPlan({required this.exercises});

  factory DayPlan.fromJson(Map<String, dynamic> json) {
    return DayPlan(
      exercises:
          (json['exercises'] as List).map((e) => Exercise.fromJson(e)).toList(),
    );
  }
}

class Exercise {
  final int workoutId;
  final int sets;
  final int reps;
  final String technique;
  final int restTime;
  final String notes;

  Exercise({
    required this.workoutId,
    required this.sets,
    required this.reps,
    required this.technique,
    required this.restTime,
    required this.notes,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      workoutId: json['workoutId'],
      sets: json['sets'],
      reps: json['reps'],
      technique: json['technique'],
      restTime: json['restTime'],
      notes: json['notes'],
    );
  }
}

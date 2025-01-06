class WorkoutDetails {
  final int id;
  final String name;
  final String category;
  final List<String> targetMuscles;
  final int sets;
  final int reps;
  final int restTime;
  final int rpe;
  final String difficultyLevel;
  final int duration;
  final String equipment;
  final String imageUrl;
  final String videoUrl;
  final String description;
  final String technique;
  final int caloriesBurned;
  final String note;

  WorkoutDetails({
    required this.id,
    required this.name,
    required this.category,
    required this.targetMuscles,
    required this.sets,
    required this.reps,
    required this.restTime,
    required this.rpe,
    required this.difficultyLevel,
    required this.duration,
    required this.equipment,
    required this.imageUrl,
    required this.videoUrl,
    required this.description,
    required this.technique,
    required this.caloriesBurned,
    required this.note,
  });

  factory WorkoutDetails.fromJson(Map<String, dynamic> json) {
    return WorkoutDetails(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      targetMuscles: List<String>.from(json['targetMuscles']),
      sets: json['sets'] ?? 0,
      reps: json['reps'] ?? 0,
      restTime: json['restTime'] ?? 0,
      rpe: json['rpe'] ?? 0,
      difficultyLevel: json['difficultyLevel'] ?? '',
      duration: json['duration'] ?? 0,
      equipment: json['equipment'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      videoUrl: json['videoUrl'] ?? '',
      description: json['description'] ?? '',
      technique: json['technique'] ?? '',
      caloriesBurned: json['caloriesBurned'] ?? 0,
      note: json['notes'] ?? '',
    );
  }
}

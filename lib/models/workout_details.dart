class WorkoutDetails {
  final int id;
  final String name;
  final String category;
  final List<String> targetMuscles;
  final String difficultyLevel;
  final int duration;
  final String equipment;
  final String imageUrl;
  final String videoUrl;
  final String description;
  final String technique;
  final int caloriesBurned;
  final String notes;

  WorkoutDetails({
    required this.id,
    required this.name,
    required this.category,
    required this.targetMuscles,
    required this.difficultyLevel,
    required this.duration,
    required this.equipment,
    required this.imageUrl,
    required this.videoUrl,
    required this.description,
    required this.technique,
    required this.caloriesBurned,
    required this.notes,
  });

  factory WorkoutDetails.fromJson(Map<String, dynamic> json) {
    return WorkoutDetails(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      targetMuscles: List<String>.from(json['targetMuscles']),
      difficultyLevel: json['difficultyLevel'],
      duration: json['duration'],
      equipment: json['equipment'],
      imageUrl: json['imageUrl'],
      videoUrl: json['videoUrl'],
      description: json['description'],
      technique: json['technique'],
      caloriesBurned: json['caloriesBurned'],
      notes: json['notes'],
    );
  }
}

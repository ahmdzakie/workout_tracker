import '../../repositories/workout_details_repository.dart';
import '../../models/workout_details.dart';

class MockWorkoutDetailsRepository implements WorkoutDetailsRepository {
  @override
  Future<List<WorkoutDetails>> getWorkoutDetails(List<int> workoutIds) async {
    await Future.delayed(const Duration(milliseconds: 800));
    
    return Future.value(workoutIds.map((id) => WorkoutDetails(
      id: id,
      name: "Bench Press",
      category: "Strength",
      equipment: "Barbell",
      targetMuscles: ["Chest", "Triceps", "Shoulders"],
      difficultyLevel: "Intermediate",
      description: "Classic compound movement for chest development",
      sets: 3,
      reps: 12,
      restTime: 90,
      rpe: 8,
      duration: 300,
      imageUrl: "",
      videoUrl: "",
      technique: "Control the weight throughout the movement",
      caloriesBurned: 150,
      note: "Keep back flat on bench"
    )).toList());
  }
}
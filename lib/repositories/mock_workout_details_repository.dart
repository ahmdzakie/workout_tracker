import '../../repositories/workout_details_repository.dart';
import '../../models/workout_details.dart';

class MockWorkoutDetailsRepository implements WorkoutDetailsRepository {
  @override
  Future<List<WorkoutDetails>> getWorkoutDetails(List<int> workoutIds) async {
    await Future.delayed(const Duration(milliseconds: 800));

    return workoutIds
        .map((id) => WorkoutDetails(
            id: id,
            name: id == 1 ? "Leg Press" : "Bulgarian Split Squat",
            category: id == 1 ? "mobility" : "strength",
            equipment: "jump rope",
            targetMuscles: id == 1
                ? ["biceps", "triceps", "glutes"]
                : ["quads", "hamstrings", "glutes"],
            difficultyLevel: id == 1 ? "beginner" : "intermediate",
            description:
                "A detailed description of the exercise and tips for correct form.",
            duration: id == 1 ? 25 : 12,
            imageUrl: id == 1
                ? "/exercises/bulgariansplitsquat.jpg"
                : "/exercises/russiantwists.jpg",
            videoUrl: id == 1
                ? "https://example.com/calf-raises-demo"
                : "https://example.com/handstand-push-ups-demo",
            technique: id == 1 ? "circuit" : "superset",
            caloriesBurned: id == 1 ? 178 : 78,
            notes: "Additional notes or tips specific to this workout."))
        .toList();
  }
}

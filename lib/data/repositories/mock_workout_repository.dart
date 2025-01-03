import '../models/workout.dart';
import 'workout_repository.dart';
class MockWorkoutRepository implements WorkoutRepository {
  final List<Workout> _mockWorkouts = [
    // Your existing hardcoded data here
    Workout(
      id: '1',
      name: 'Monday Chest Workout',
      description: 'Focus on chest and triceps',
      exercises: [
        Exercise(
          name: 'Bench Press',
          sets: 3,
          reps: 12,
          intensity: "9",
          weight: '60kg',
          muscleGroup: MuscleGroup.UpperBody,
          equipment: Equipment.Dumbbells,
          category: Category.Strength,
          skillLevel: SkillLevel.Beginner,
          description: "Lay down on the bench and start with a bench press. "
        ),
        // Add more exercises
      ],
      date: DateTime.now(),
      dayOfWeek: 'Monday',
    ),
    // Add more workouts
  ];

  @override
  Future<List<Workout>> getWorkouts() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    return _mockWorkouts;
  }

  @override
  Future<Workout> getWorkoutById(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockWorkouts.firstWhere((workout) => workout.id == id);
  }

  @override
  Future<List<Workout>> getWorkoutsByDate(DateTime date) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockWorkouts.where((workout) =>
      workout.date.year == date.year &&
      workout.date.month == date.month &&
      workout.date.day == date.day
    ).toList();
  }
}

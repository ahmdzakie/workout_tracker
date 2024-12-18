import '../models/workout.dart';
abstract class WorkoutRepository {
  Future<List<Workout>> getWorkouts();
  Future<Workout> getWorkoutById(String id);
  Future<List<Workout>> getWorkoutsByDate(DateTime date);
}

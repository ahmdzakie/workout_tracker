import '../../models/workout_details.dart';

abstract class WorkoutDetailsRepository {
  Future<List<WorkoutDetails>> getWorkoutDetails(List<int> workoutIds);
}

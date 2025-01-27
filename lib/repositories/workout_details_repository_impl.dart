import 'package:workout_tracker/services/api/workout_api_client.dart';
import 'workout_details_repository.dart';
import 'package:workout_tracker/models/workout_details.dart';

class WorkoutDetailsRepositoryImpl implements WorkoutDetailsRepository {
  final WorkoutApiClient apiClient;

  WorkoutDetailsRepositoryImpl(this.apiClient);

  @override
  Future<List<WorkoutDetails>> getWorkoutDetails(List<int> workoutIds) {
    return apiClient.getWorkoutDetails(workoutIds);
  }
}

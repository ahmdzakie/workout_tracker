class WorkoutDetailsRepositoryImpl implements WorkoutDetailsRepository {
  final WorkoutApiClient apiClient;

  WorkoutDetailsRepositoryImpl(this.apiClient);

  @override
  Future<List<WorkoutDetails>> getWorkoutDetails(List<int> workoutIds) {
    return apiClient.getWorkoutDetails(workoutIds);
  }
}

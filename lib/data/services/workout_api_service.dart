abstract class WorkoutApiService {
  Future<List<dynamic>> fetchWorkouts();
  Future<Map<String, dynamic>> fetchWorkoutById(String id);
  Future<List<dynamic>> fetchWorkoutsByDate(DateTime date);
}


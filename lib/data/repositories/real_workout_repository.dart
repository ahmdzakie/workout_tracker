import '../models/workout.dart';
import '../services/workout_api_service.dart';
import 'workout_repository.dart';
class RealWorkoutRepository implements WorkoutRepository {
  final WorkoutApiService _apiService;

  RealWorkoutRepository(this._apiService);

  @override
  Future<List<Workout>> getWorkouts() async {
    final jsonData = await _apiService.fetchWorkouts();
    return jsonData.map((json) => Workout.fromJson(json)).toList();
  }

  @override
  Future<Workout> getWorkoutById(String id) async {
    final jsonData = await _apiService.fetchWorkoutById(id);
    return Workout.fromJson(jsonData);
  }

  @override
  Future<List<Workout>> getWorkoutsByDate(DateTime date) {
    // TODO: implement getWorkoutsByDate
    throw UnimplementedError();
  }
}

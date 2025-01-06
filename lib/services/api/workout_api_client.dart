import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:workout_tracker/models/workout_details.dart';

class WorkoutApiClient {
  final String baseUrl = 'http://127.0.0.1:5000/api';
  final http.Client _httpClient;

  WorkoutApiClient(): _httpClient = http.Client();

  Future<List<WorkoutDetails>> getWorkoutDetails(List<int> workoutIds) async {
    // For now, fetch each workout individually
    final futures = workoutIds.map((id) => _getWorkoutDetail(id));
    return Future.wait(futures);
  }

  Future<WorkoutDetails> _getWorkoutDetail(int workoutId) async {
    final url = '$baseUrl/workouts/$workoutId';
    
    final response = await _httpClient.get(Uri.parse(url));

    if (response.statusCode == 200) {
      try {
        return WorkoutDetails.fromJson(jsonDecode(response.body));
      } catch (e) {
        throw Exception('Failed to parse workout detail for ID: $workoutId');
      }
    } else {
      throw Exception('Failed to load workout detail for ID: $workoutId');
    }
  }
}


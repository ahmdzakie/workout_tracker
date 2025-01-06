import "dart:convert";

import "package:http/http.dart" as http;
import "package:workout_tracker/models/workout_plan.dart";

class WorkoutPlanApiClient {
  final String baseUrl = "http://127.0.0.1:5000/api";
  final http.Client _httpClient;

  WorkoutPlanApiClient(): _httpClient = http.Client();


  Future<WorkoutPlan> getCurrentPlan() async {
    final response = await _httpClient.get(Uri.parse('$baseUrl/trainee/1/workout-plans/1'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return WorkoutPlan.fromJson(jsonData);
    } else {
      throw Exception(
          'Server returned ${response.statusCode}: ${response.body}');
    }
  }

  Future<List<WorkoutPlan>> getPreviousPlans() async {
    final response =
        await _httpClient.get(Uri.parse('$baseUrl/workout-plans/history'));
    final List<dynamic> plans = jsonDecode(response.body);
    return plans.map((plan) => WorkoutPlan.fromJson(plan)).toList();
  }
}

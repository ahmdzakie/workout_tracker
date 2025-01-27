import 'dart:convert';
import 'package:http/http.dart' as http;
import 'diet_api_service.dart';

class RealDietApiService implements DietApiService {
  final String baseUrl = 'http://127.0.0.1:5000/api/trainees/1';
  final http.Client _client = http.Client();

  @override
  Future<Map<String, dynamic>> fetchDietPlan() async {
    final response = await _client.get(Uri.parse('$baseUrl/diet-plans/1'));
    if (response.statusCode == 201 || response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to load diet plan');
  }

  @override
  Future<Map<String, dynamic>> fetchDietPlanById(String id) async {
    final response = await _client.get(Uri.parse('$baseUrl/diet-plans/1/$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to load diet plan');
  }
}

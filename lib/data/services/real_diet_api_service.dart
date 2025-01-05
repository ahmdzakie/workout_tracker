class RealDietApiService implements DietApiService {
  final String baseUrl = 'https://your-api.com/api';
  final http.Client _client = http.Client();

  @override
  Future<Map<String, dynamic>> fetchDietPlan() async {
    final response = await _client.get(Uri.parse('$baseUrl/diet-plan'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to load diet plan');
  }

  @override
  Future<Map<String, dynamic>> fetchDietPlanById(String id) async {
    final response = await _client.get(Uri.parse('$baseUrl/diet-plan/$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to load diet plan');
  }
}

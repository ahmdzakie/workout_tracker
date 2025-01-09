abstract class DietApiService {
  Future<Map<String, dynamic>> fetchDietPlan();
  Future<Map<String, dynamic>> fetchDietPlanById(String id);
}

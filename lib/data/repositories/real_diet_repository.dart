import 'diet_repository.dart';
import '../services/diet_api_service.dart';
import '../models/diet_plan.dart';

class RealDietRepository implements DietRepository {
  final DietApiService _apiService;

  RealDietRepository(this._apiService);

  @override
  Future<DietPlan> getDietPlan() async {
    final jsonData = await _apiService.fetchDietPlan();
    return DietPlan.fromJson(jsonData);
  }

  @override
  Future<DietPlan> getDietPlanById(String id) async {
    final jsonData = await _apiService.fetchDietPlanById(id);
    return DietPlan.fromJson(jsonData);
  }
}

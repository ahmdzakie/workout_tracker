import '../models/diet_plan.dart';
abstract class DietRepository {
  Future<DietPlan> getDietPlan();
  Future<DietPlan> getDietPlanById(String id);
}

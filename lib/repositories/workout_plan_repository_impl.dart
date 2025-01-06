import '../models/workout_plan.dart';
import '../services/api/workout_plan_api_client.dart';
import 'workout_plan_repository.dart';

class WorkoutPlanRepositoryImpl implements WorkoutPlanRepository {
  final WorkoutPlanApiClient apiClient;

  WorkoutPlanRepositoryImpl(this.apiClient);

  @override
  Future<WorkoutPlan> getCurrentPlan() async {
    return await apiClient.getCurrentPlan();
  }

  @override
  Future<List<WorkoutPlan>> getPreviousPlans() async {
    return await apiClient.getPreviousPlans();
  }
}

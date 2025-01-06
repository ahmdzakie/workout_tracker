import '../models/workout_plan.dart';

abstract class WorkoutPlanRepository {
  Future<WorkoutPlan> getCurrentPlan();
  Future<List<WorkoutPlan>> getPreviousPlans();
}

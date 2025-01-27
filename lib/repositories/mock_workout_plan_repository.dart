import '../../models/workout_plan.dart';
import '../../repositories/workout_plan_repository.dart';

enum MuscleGroup { UpperBody, LowerBody, Core, FullBody }

enum Equipment { Barbell, Dumbbells, Machines, Bodyweight, Other }

enum Category { Strength, Cardio, Flexibility, Balance }

enum SkillLevel { Beginner, Intermediate, Advanced, Expert }

class MockWorkoutPlanRepository implements WorkoutPlanRepository {
  final WorkoutPlan _mockWorkoutPlan = WorkoutPlan(
    id: 3,
    name: "Good Work",
    description: "This is a workout plan.",
    startDate: "2025-01-17",
    endDate: "2025-02-14",
    status: "completed",
    monday: DayPlan(
      exercises: [],
    ),
    tuesday: DayPlan(
      exercises: [
        Exercise(
          workoutId: 1,
          sets: 2,
          reps: 19,
          technique: "circuit",
          restTime: 94,
          notes: "Additional notes or tips specific to this workout.",
        ),
        Exercise(
          workoutId: 2,
          sets: 5,
          reps: 11,
          technique: "superset",
          restTime: 76,
          notes: "Additional notes or tips specific to this workout.",
        ),
      ],
    ),
    wednesday: DayPlan(
      exercises: [
        Exercise(
          workoutId: 1,
          sets: 2,
          reps: 19,
          technique: "circuit",
          restTime: 94,
          notes: "Additional notes or tips specific to this workout.",
        ),
      ],
    ),
    thursday: DayPlan(exercises: []),
    friday: DayPlan(exercises: []),
    saturday: DayPlan(exercises: []),
    sunday: DayPlan(exercises: []),
  );

  @override
  Future<WorkoutPlan> getCurrentPlan() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _mockWorkoutPlan;
  }

  @override
  Future<List<WorkoutPlan>> getPreviousPlans() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [_mockWorkoutPlan];
  }
}

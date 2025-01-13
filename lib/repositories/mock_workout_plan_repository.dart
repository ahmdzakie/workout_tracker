  import '../../models/workout_plan.dart';
  import '../../repositories/workout_plan_repository.dart';

  enum MuscleGroup {
    UpperBody,
    LowerBody,
    Core,
    FullBody
  }

  enum Equipment {
    Barbell,
    Dumbbells,
    Machines,
    Bodyweight,
    Other
  }

  enum Category {
    Strength,
    Cardio,
    Flexibility,
    Balance
  }

  enum SkillLevel {
    Beginner,
    Intermediate,
    Advanced,
    Expert
  }
class MockWorkoutPlanRepository implements WorkoutPlanRepository {
    final WorkoutPlan _mockWorkoutPlan = WorkoutPlan(
    id: 1,
    name: "Strength Building Program",
    description: "12-week progressive strength training",
    monday: DayPlan(
        name: "Monday",
        exercises: [
        Exercise(
            workoutId: 1,
            sets: 4,
            reps: 12,
            technique: "Standard",
            rpe: 8,
            notes: "Keep shoulders retracted",
            restTime: 90,
        ),
        ],
    ),
    tuesday: DayPlan(
        name: "Tuesday",
        exercises: [
        Exercise(
            workoutId: 2,
            sets: 5,
            reps: 10,
            technique: "Controlled",
            rpe: 7,
            notes: "Focus on form",
            restTime: 60,
        ),
        ],
    ),
    wednesday: DayPlan(
        name: "Wednesday",
        exercises: [],
    ),
    thursday: DayPlan(
        name: "Thursday",
        exercises: [],
    ),
    friday: DayPlan(
        name: "Friday",
        exercises: [],
    ),
    saturday: DayPlan(
        name: "Saturday",
        exercises: [],
    ),
    sunday: DayPlan(
        name: "Sunday",
        exercises: [],
    ),
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
import 'package:flutter/material.dart';
import '../data/models/workout.dart';
import '../data/repositories/workout_repository.dart';
import '../data/repositories/mock_workout_repository.dart';
import '../widgets/workout_card.dart';  // Assuming you have this widget
class WorkoutListScreen extends StatefulWidget {
  @override
  _WorkoutListScreenState createState() => _WorkoutListScreenState();
}

class _WorkoutListScreenState extends State<WorkoutListScreen> {
  final WorkoutRepository repository = MockWorkoutRepository();
  List<Workout> workouts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadWorkouts();
  }

  Future<void> loadWorkouts() async {
    setState(() => isLoading = true);
    try {
      print('Starting to load workouts');
      workouts = await repository.getWorkouts();
      print('Loaded ${workouts.length} workouts');
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: workouts.length,
      itemBuilder: (context, index) {
        final workout = workouts[index];
        return WorkoutCard(workout: workout);
      },
    );
  }
}

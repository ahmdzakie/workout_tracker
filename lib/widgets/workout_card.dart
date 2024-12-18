import 'package:flutter/material.dart';
import '../data/models/workout.dart';

class WorkoutCard extends StatelessWidget {
  final Workout workout;

  const WorkoutCard({Key? key, required this.workout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              workout.name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 8),
            Text(
              workout.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 16),
            Text(
              'Exercises: ${workout.exercises.length}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              'Day: ${workout.dayOfWeek}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

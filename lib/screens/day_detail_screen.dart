import 'package:flutter/material.dart';
// import '../data/models/workout.dart';
import '../models/workout_plan.dart';

class DayDetailScreen extends StatelessWidget {
  final DayPlan dayPlan;

  const DayDetailScreen({
    required this.dayPlan,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        title: Text(
          '${dayPlan.name} Workout',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: dayPlan.exercises.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.fitness_center,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No exercises planned for ${dayPlan.name}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: dayPlan.exercises.length,
              itemBuilder: (context, index) {
                final exercise = dayPlan.exercises[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      childrenPadding: const EdgeInsets.all(16.0),
                      title: Text(
                        // disply the int ID
                        '$exercise.id', // We might need to fetch exercise details using this ID
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(
                        '${exercise.sets} sets × ${exercise.reps} reps',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      children: [
                        _buildDetailRow('Technique', exercise.technique),
                        _buildDetailRow('RPE', exercise.rpe.toString()),
                        _buildDetailRow(
                            'Rest Time', '${exercise.restTime} seconds'),
                        if (exercise.notes.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Notes',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                exercise.notes,
                                style: const TextStyle(height: 1.4),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          Text(value),
        ],
      ),
    );
  }
}

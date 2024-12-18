import 'package:flutter/material.dart';
import '../data/models/workout.dart';

class DayDetailScreen extends StatelessWidget {
  final String day;
  final List<Exercise> exercises;

  const DayDetailScreen({
    required this.day,
    required this.exercises,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        title: Text(
          '$day Workout',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: exercises.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.fitness_center,
              size: 64,
              color: Colors.grey[400],
            ),
            SizedBox(height: 16),
            Text(
              'No exercises planned for $day',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final exercise = exercises[index];
          return Container(
            margin: EdgeInsets.only(bottom: 12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                childrenPadding: EdgeInsets.all(16.0),
                title: Text(
                  exercise.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: Text(
                  '${exercise.sets} sets × ${exercise.reps} reps',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                children: [
                  _buildDetailRow('Category', exercise.category.toString().split('.').last),
                  _buildDetailRow('Muscle Group', exercise.muscleGroup.toString().split('.').last),
                  _buildDetailRow('Equipment', exercise.equipment.toString().split('.').last),
                  _buildDetailRow('Skill Level', exercise.skillLevel.toString().split('.').last),
                  _buildDetailRow('Intensity', exercise.intensity),
                  SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        exercise.description,
                        style: TextStyle(height: 1.4),
                      ),
                    ],
                  ),
                  if (exercise.notes != null) ...[
                    SizedBox(height: 12),
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
                        SizedBox(height: 4),
                        Text(
                          exercise.notes!,
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.grey[600],
                          ),
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
      padding: EdgeInsets.only(bottom: 8.0),
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

import 'package:flutter/material.dart';
import 'package:workout_tracker/models/workout_details.dart';
import 'package:workout_tracker/services/api/workout_api_client.dart';
import 'package:workout_tracker/services/cache/workout_details_cache.dart';
import 'package:workout_tracker/services/service_locator.dart';
import '../models/workout_plan.dart';

class DayDetailScreen extends StatefulWidget {
  final DayPlan dayPlan;

  const DayDetailScreen({
    required this.dayPlan,
    super.key,
  });

  @override
  State<DayDetailScreen> createState() => _DayDetailScreenState();
}

class _DayDetailScreenState extends State<DayDetailScreen> {
  final _cache = getIt<WorkoutDetailsCache>();
  final _apiClient = getIt<WorkoutApiClient>();
  late Future<void> _workoutDetailsFuture;

  @override
  void initState() {
    super.initState();
    _workoutDetailsFuture = _loadWorkoutDetails();
  }

  Future<void> _loadWorkoutDetails() async {
    final workoutIds = widget.dayPlan.exercises.map((e) => e.workoutId).toList();
    final missingIds = _cache.getMissingIds(workoutIds);
    
    if (missingIds.isNotEmpty) {
      final details = await _apiClient.getWorkoutDetails(missingIds);
      _cache.storeAll(details);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        title: Text(
          '${widget.dayPlan.name} Workout',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<void>(
        future: _workoutDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error loading workout details: ${snapshot.error}'),
            );
          }

          return _buildWorkoutList();
        },
      ),
    );
  }

  Widget _buildWorkoutList() {
    if (widget.dayPlan.exercises.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: widget.dayPlan.exercises.length,
      itemBuilder: (context, index) {
        final exercise = widget.dayPlan.exercises[index];
        final workoutDetails = _cache.get(exercise.workoutId);

        if (workoutDetails == null) {
          return const SizedBox(); // Should never happen due to preloading
        }

        return _buildExerciseCard(exercise, workoutDetails);
      },
    );
  }

  Widget _buildExerciseCard(Exercise exercise, WorkoutDetails details) {
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
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          childrenPadding: const EdgeInsets.all(16.0),
          title: Text(
            details.name,
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
            _buildDetailRow('Category', details.category),
            _buildDetailRow('Equipment', details.equipment),
            _buildDetailRow('Target Muscles', details.targetMuscles.join(', ')),
            _buildDetailRow('Difficulty', details.difficultyLevel),
            _buildDetailRow('Technique', exercise.technique),
            _buildDetailRow('RPE', exercise.rpe.toString()),
            _buildDetailRow('Rest Time', '${exercise.restTime} seconds'),
            if (details.description.isNotEmpty) ...[
              const SizedBox(height: 8),
              _buildDescriptionSection('Description', details.description),
            ],
            if (exercise.notes.isNotEmpty) ...[
              const SizedBox(height: 8),
              _buildDescriptionSection('Notes', exercise.notes),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
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
            'No exercises planned for ${widget.dayPlan.name}',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection(String label, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          content,
          style: const TextStyle(height: 1.4),
        ),
      ],
    );
  }
}

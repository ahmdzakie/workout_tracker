import 'package:flutter/material.dart';
import 'package:workout_tracker/models/workout_details.dart';
import 'package:workout_tracker/repositories/mock_workout_details_repository.dart';
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
  final _repository = MockWorkoutDetailsRepository(); // For now using mock
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
      final details = await _repository.getWorkoutDetails(missingIds);
      _cache.storeAll(details);
    }
  }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.grey[100],
        body: FutureBuilder(
          future: _workoutDetailsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
          
            if (snapshot.hasError) {
              return Center(child: Text('Error loading workout details'));
            }

            return CustomScrollView(
              slivers: [
                _buildSliverAppBar(),
                SliverToBoxAdapter(
                  child: _buildWorkoutOverview(),
                ),
                _buildExercisesList(),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Start workout functionality
          },
          backgroundColor: Colors.blue,
          icon: const Icon(Icons.play_arrow),
          label: const Text('Start Workout'),
        ),
      );
    }
  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(widget.dayPlan.name),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue[400]!,
                Colors.blue[800]!,
              ],
            ),
          ),
          child: Center(
            child: Icon(
              Icons.fitness_center,
              size: 80,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWorkoutOverview() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildWorkoutStat(
                Icons.fitness_center,
                '${widget.dayPlan.exercises.length}',
                'Exercises',
              ),
              _buildWorkoutStat(
                Icons.timer,
                '${calculateTotalDuration() ~/ 60}',
                'Minutes',
              ),
              _buildWorkoutStat(
                Icons.local_fire_department,
                '${calculateTotalCalories()}',
                'Calories',
              ),
            ],
          ),
        ],
      ),
    );
  }

  int calculateTotalDuration() {
    return widget.dayPlan.exercises.fold(0, (total, exercise) {
      final details = _cache.get(exercise.workoutId);
      if (details == null) return total;
      return total + details.duration + (exercise.sets * exercise.restTime);
    });
  }

  int calculateTotalCalories() {
    return widget.dayPlan.exercises.fold(0, (total, exercise) {
      final details = _cache.get(exercise.workoutId);
      return total + (details?.caloriesBurned ?? 0);
    });
  }
  Widget _buildWorkoutStat(IconData icon, String value, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: Colors.blue[400],
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildExercisesList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final exercise = widget.dayPlan.exercises[index];
          final details = _cache.get(exercise.workoutId);
          
          if (details == null) {
            return const SizedBox.shrink();
          }

          return _buildExerciseCard(exercise, details);
        },
        childCount: widget.dayPlan.exercises.length,
      ),
    );
  }

  Widget _buildExerciseCard(Exercise exercise, WorkoutDetails details) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
          childrenPadding: const EdgeInsets.all(20),
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.fitness_center,
              color: Colors.blue[400],
            ),
          ),
          title: Text(
            details.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            '${exercise.sets} sets × ${exercise.reps} reps',
            style: TextStyle(color: Colors.grey[600]),
          ),
          children: [
            _buildExerciseDetail('Category', details.category),
            _buildExerciseDetail('Equipment', details.equipment),
            _buildExerciseDetail('Target Muscles', details.targetMuscles.join(', ')),
            _buildExerciseDetail('Difficulty', details.difficultyLevel),
            _buildExerciseDetail('Technique', exercise.technique),
            _buildExerciseDetail('RPE', exercise.rpe.toString()),
            _buildExerciseDetail('Rest Time', '${exercise.restTime} seconds'),
            if (details.description.isNotEmpty) ...[
              const SizedBox(height: 10),
              Text(
                details.description,
                style: const TextStyle(height: 1.5),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
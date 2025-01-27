import 'package:flutter/material.dart';
import 'package:workout_tracker/models/workout_details.dart';
import 'package:workout_tracker/repositories/mock_workout_details_repository.dart';
import 'package:workout_tracker/repositories/workout_details_repository_impl.dart';
import 'package:workout_tracker/services/api/workout_api_client.dart';
import 'package:workout_tracker/widgets/video_player_widget.dart';
import 'package:workout_tracker/services/cache/workout_details_cache.dart';
import 'package:workout_tracker/services/service_locator.dart';
import '../models/workout_plan.dart';
import 'package:google_fonts/google_fonts.dart';

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
  final _repository =
      MockWorkoutDetailsRepository(); //WorkoutDetailsRepositoryImpl(WorkoutApiClient());

  late Future<void> _workoutDetailsFuture;

  @override
  void initState() {
    super.initState();
    _workoutDetailsFuture = _loadWorkoutDetails();
  }

  Future<void> _loadWorkoutDetails() async {
    final workoutIds =
        widget.dayPlan.exercises.map((e) => e.workoutId).toList();
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
            return Center(
              child: Text(
                'Error loading workout details',
                style: GoogleFonts.poppins(),
              ),
            );
          }

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
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
        backgroundColor: Colors.blue[600],
        elevation: 8,
        icon: const Icon(Icons.play_arrow),
        label: Text(
          'Start Workout',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
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
        child: FlexibleSpaceBar(
          centerTitle: false,
          titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
          title: Text(
            'Workout Details',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
            ),
          ),
          background: Stack(
            children: [
              Center(
                child: Icon(
                  Icons.fitness_center,
                  size: 80,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
              Positioned(
                right: -50,
                top: -50,
                child: CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.white.withOpacity(0.1),
                ),
              ),
              Positioned(
                left: -30,
                bottom: -30,
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.white.withOpacity(0.1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWorkoutOverview() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
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

  Widget _buildWorkoutStat(IconData icon, String value, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            icon,
            color: Colors.blue[400],
            size: 30,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
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
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          childrenPadding: const EdgeInsets.all(20),
          leading: _buildExerciseImage(details.imageUrl),
          title: Text(
            details.name,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            '${exercise.sets} sets × ${exercise.reps} reps',
            style: GoogleFonts.poppins(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          children: [
            if (details.imageUrl.isNotEmpty) _buildFullImage(details.imageUrl),
            if (details.videoUrl.isNotEmpty)
              VideoPlayerWidget(videoUrl: details.videoUrl),
            _buildExerciseDetail('Category', details.category),
            _buildExerciseDetail('Equipment', details.equipment),
            _buildExerciseDetail(
                'Target Muscles', details.targetMuscles.join(', ')),
            _buildExerciseDetail('Difficulty', details.difficultyLevel),
            _buildExerciseDetail('Technique', exercise.technique),
            _buildExerciseDetail('Rest Time', '${exercise.restTime} seconds'),
            if (details.description.isNotEmpty) ...[
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  details.description,
                  style: GoogleFonts.poppins(
                    height: 1.5,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseImage(String imageUrl) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(20),
        image: imageUrl.isNotEmpty
            ? DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: imageUrl.isEmpty
          ? Icon(
              Icons.fitness_center,
              color: Colors.blue[400],
            )
          : null,
    );
  }

  Widget _buildFullImage(String imageUrl) {
    return Container(
      height: 200,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildExerciseDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.poppins(
                color: Colors.grey[900],
              ),
            ),
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
}

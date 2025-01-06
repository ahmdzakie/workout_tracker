import 'package:flutter/material.dart';
import 'package:workout_tracker/repositories/workout_plan_repository.dart';
import 'package:workout_tracker/repositories/workout_plan_repository_impl.dart';
import '../data/models/workout.dart';
import '../data/repositories/workout_repository.dart';
import '../data/repositories/mock_workout_repository.dart';
import '../models/workout_plan.dart';
import '../services/api/workout_plan_api_client.dart';
import 'day_detail_screen.dart';

class PlansScreen extends StatefulWidget {
  const PlansScreen({super.key});

  @override
  _PlansScreenState createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen> {
  final WorkoutRepository repository = MockWorkoutRepository();
  List<Workout> workouts = [];
  final WorkoutPlanRepository workoutPlanRepository =
      WorkoutPlanRepositoryImpl(WorkoutPlanApiClient());
  WorkoutPlan? currentPlan;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadWorkoutPlan();
  }

  Future<void> loadWorkoutPlan() async {
    setState(() => isLoading = true);
    try {
      currentPlan = await workoutPlanRepository.getCurrentPlan();
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          title: const Text(
            'Workout Plans',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          bottom: const TabBar(
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
            tabs: [
              Tab(text: 'CURRENT PLAN'),
              Tab(text: 'PREVIOUS PLANS'),
            ],
          ),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : TabBarView(
                children: [
                  _buildCurrentPlan(context),
                  _buildPreviousPlans(),
                ],
              ),
      ),
    );
  }

  Widget _buildCurrentPlan(BuildContext context) {
    if (currentPlan == null) {
      return const Center(child: Text('No workout plan available'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: currentPlan!.getAllPlanDays().length,
      itemBuilder: (context, index) {
        final dayPlan = currentPlan!.getAllPlanDays()[index];

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            title: Text(
              dayPlan.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              '${dayPlan.exercises.length} exercises',
              style: TextStyle(color: Colors.grey[600]),
            ),
            trailing: Container(
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(8),
              child: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.blue,
                size: 16,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DayDetailScreen(dayPlan: dayPlan),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildPreviousPlans() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text('Previous Plan ${index + 1}'),
            subtitle: Text('Completed: ${2023 - index}'),
            trailing: const Icon(Icons.history),
            onTap: () {
              // Navigate to historical plan view
            },
          ),
        );
      },
    );
  }
}

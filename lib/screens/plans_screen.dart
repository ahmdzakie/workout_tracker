import 'package:flutter/material.dart';
import '../data/models/workout.dart';
import '../data/repositories/workout_repository.dart';
import '../data/repositories/mock_workout_repository.dart';
import 'day_detail_screen.dart';

class PlansScreen extends StatefulWidget {
  const PlansScreen({super.key});

  @override
  _PlansScreenState createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen> {
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          title: Text(
            'Workout Plans',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          bottom: TabBar(
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
            ? Center(child: CircularProgressIndicator())
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
    final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: days.length,
      itemBuilder: (context, index) {
        final day = days[index];
        final dayWorkout = workouts.firstWhere(
          (w) => w.dayOfWeek == day,
          orElse: () => Workout(
            id: '',
            name: '',
            description: '',
            exercises: [],
            date: DateTime.now(),
            dayOfWeek: day,
          ),
        );

        return Container(
          margin: EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            title: Text(
              day,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              '${dayWorkout.exercises.length} exercises',
              style: TextStyle(color: Colors.grey[600]),
            ),
            trailing: Container(
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(8),
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.blue,
                size: 16,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DayDetailScreen(
                    day: day,
                    exercises: dayWorkout.exercises,
                  ),
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
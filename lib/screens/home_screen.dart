import 'package:flutter/material.dart';
import '../data/repositories/workout_repository.dart';
import '../data/repositories/mock_workout_repository.dart';
import '../data/models/workout.dart';
import 'day_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Tracker'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome back!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildTodayWorkout(context),
              const SizedBox(height: 20),
              _buildProgressSection(),
              const SizedBox(height: 20),
              _buildQuickActions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTodayWorkout(BuildContext context) {
    //TODO: Change the mockworkoutRepository with  actual repository
    final WorkoutRepository repository = MockWorkoutRepository();
    final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    final today = days[DateTime.now().weekday - 1];

    return FutureBuilder<List<Workout>>(
      future: repository.getWorkouts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Card(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final todayWorkout = snapshot.data?.firstWhere(
          (w) => w.dayOfWeek == today,
          orElse: () => Workout(
            id: '',
            name: 'Rest Day',
            description: 'No workout scheduled',
            exercises: [],
            date: DateTime.now(),
            dayOfWeek: today,
          ),
        );

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Today\'s Workout ($today)',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ListTile(
                  leading: const Icon(Icons.fitness_center),
                  title: Text(todayWorkout?.name ?? 'Rest Day'),
                  subtitle: Text('${todayWorkout?.exercises.length ?? 0} exercises'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => DayDetailScreen(
                      //       day: today,
                      //       exercises: todayWorkout?.exercises ?? [],
                      //     ),
                      //   ),
                      // );
                    },
                    child: const Text('Start'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  Widget _buildProgressSection() {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Weekly Progress',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            LinearProgressIndicator(
              value: 0.7,
              minHeight: 10,
            ),
            SizedBox(height: 10),
            Text('5 out of 7 workouts completed'),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quick Actions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionButton(Icons.calendar_today, 'Schedule'),
                _buildActionButton(Icons.history, 'History'),
                _buildActionButton(Icons.insights, 'Stats'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon),
          onPressed: () {},
          iconSize: 30,
        ),
        Text(label),
      ],
    );
  }
}
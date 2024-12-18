import 'package:flutter/material.dart';

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
              _buildTodayWorkout(),
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

  Widget _buildTodayWorkout() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Today\'s Workout',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.fitness_center),
              title: const Text('Upper Body Strength'),
              subtitle: const Text('45 minutes'),
              trailing: ElevatedButton(
                onPressed: () {},
                child: const Text('Start'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Weekly Progress',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const LinearProgressIndicator(
              value: 0.7,
              minHeight: 10,
            ),
            const SizedBox(height: 10),
            const Text('5 out of 7 workouts completed'),
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
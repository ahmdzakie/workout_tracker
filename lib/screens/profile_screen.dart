import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            const SizedBox(height: 16),
            const Text(
              'John Doe',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            _buildProfileItem(Icons.email, 'Email', 'john@example.com'),
            _buildProfileItem(Icons.fitness_center, 'Active since', 'January 2024'),
            _buildProfileItem(Icons.calendar_today, 'Next workout', 'Tomorrow'),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 16, color: Colors.grey)),
              Text(value, style: const TextStyle(fontSize: 18)),
            ],
          ),
        ],
      ),
    );
  }
}
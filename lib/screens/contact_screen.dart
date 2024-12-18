import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Get in Touch',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildContactCard(
              icon: Icons.email,
              title: 'Email Us',
              subtitle: 'support@workouttracker.com',
              onTap: () {},
            ),
            _buildContactCard(
              icon: Icons.phone,
              title: 'Call Us',
              subtitle: '+1 234 567 8900',
              onTap: () {},
            ),
            _buildContactCard(
              icon: Icons.chat,
              title: 'Live Chat',
              subtitle: 'Available 24/7',
              onTap: () {},
            ),
            const SizedBox(height: 30),
            const Text(
              'Send us a message',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildContactForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, size: 30),
        title: Text(title),
        subtitle: Text(subtitle),
        onTap: onTap,
      ),
    );
  }

  Widget _buildContactForm() {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'Name',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          maxLines: 4,
          decoration: InputDecoration(
            labelText: 'Message',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {},
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Text('Send Message'),
          ),
        ),
      ],
    );
  }
}
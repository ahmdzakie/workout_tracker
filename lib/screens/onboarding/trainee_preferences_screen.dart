import 'package:flutter/material.dart';
import '../../data/models/trainee_profile.dart';

class TraineePreferencesScreen extends StatefulWidget {
  final Function(TraineePreferences) onNext;
  final TraineePreferences? initialData;

  const TraineePreferencesScreen({
    super.key,
    required this.onNext,
    this.initialData,
  });

  @override
  State<TraineePreferencesScreen> createState() =>
      _TraineePreferencesScreenState();
}

class _TraineePreferencesScreenState extends State<TraineePreferencesScreen> {
  late final List<String> _selectedGoals;
  late final List<String> _selectedDays;
  late String _preferredTime;
  late final List<String> _selectedEquipment;
  late final TextEditingController _dietaryController;
  late final TextEditingController _occupationController;
  late double _stressLevel;
  late double _sleepHours;
  final _goalController = TextEditingController();
  bool _showCustomGoalInput = false;
  final _equipmentController = TextEditingController();
  bool _showCustomEquipmentInput = false;

  @override
  void initState() {
    super.initState();
    _selectedGoals = widget.initialData?.fitnessGoals.toList() ?? [];
    _selectedDays = widget.initialData?.availableDays.toList() ?? [];
    _preferredTime = widget.initialData?.preferredTrainingTime ?? 'Morning';
    _selectedEquipment = widget.initialData?.equipmentAccess.toList() ?? [];
    _dietaryController = TextEditingController(
        text: widget.initialData?.dietaryRestrictions.join('\n'));
    _occupationController =
        TextEditingController(text: widget.initialData?.lifestyle.occupation);
    _stressLevel = widget.initialData?.lifestyle.stressLevel.toDouble() ?? 5;
    _sleepHours = widget.initialData?.lifestyle.sleepHours.toDouble() ?? 7;
  }

  final List<String> _availableGoals = [
    'Build muscle',
    'Lose weight',
    'Improve endurance',
    'Increase strength',
    'Enhance flexibility',
    'Better posture',
    'Sports performance',
    'General fitness',
    'Other'
  ];

  final List<String> _weekDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  final List<String> _timePreferences = [
    'Morning',
    'Afternoon',
    'Evening',
    'Late night'
  ];

  final List<String> _equipmentOptions = [
    'No equipment',
    'Gym membership',
    'Home dumbbells',
    'Resistance bands',
    'Pull-up bar',
    'Yoga mat',
    'Cardio equipment',
    'Other'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Preferences'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Fitness Goals'),
            _buildGoalsGrid(),
            _buildSectionTitle('Available Days'),
            _buildDaysSelector(),
            _buildSectionTitle('Preferred Training Time'),
            _buildTimePreference(),
            _buildSectionTitle('Equipment Access'),
            _buildEquipmentGrid(),
            _buildSectionTitle('Dietary Restrictions'),
            TextField(
              controller: _dietaryController,
              decoration: const InputDecoration(
                hintText: 'List any dietary restrictions...',
                border: OutlineInputBorder(),
              ),
            ),
            _buildSectionTitle('Lifestyle Factors'),
            TextField(
              controller: _occupationController,
              decoration: const InputDecoration(
                labelText: 'Occupation',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Stress Level (1-10)'),
            Slider(
              value: _stressLevel,
              min: 1,
              max: 10,
              divisions: 9,
              label: _stressLevel.round().toString(),
              onChanged: (value) {
                setState(() => _stressLevel = value);
              },
            ),
            const Text('Average Sleep Hours'),
            Slider(
              value: _sleepHours,
              min: 4,
              max: 12,
              divisions: 16,
              label: '${_sleepHours.round()} hours',
              onChanged: (value) {
                setState(() => _sleepHours = value);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: _submitForm,
          child: const Text('Complete'),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildGoalsGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            // Predefined goals
            ..._availableGoals.map((goal) {
              final isSelected = _selectedGoals.contains(goal);
              return FilterChip(
                label: Text(goal),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (goal == 'Other') {
                      _showCustomGoalInput = selected;
                    }
                    if (selected) {
                      _selectedGoals.add(goal);
                    } else {
                      _selectedGoals.remove(goal);
                      if (goal == 'Other') {
                        _showCustomGoalInput = false;
                      }
                    }
                  });
                },
              );
            }),
            // Custom goals
            ..._selectedGoals
                .where((goal) => !_availableGoals.contains(goal))
                .map((customGoal) {
              return FilterChip(
                label: Text(customGoal),
                selected: true,
                onSelected: (selected) {
                  setState(() {
                    if (!selected) {
                      _selectedGoals.remove(customGoal);
                    }
                  });
                },
              );
            }),
          ],
        ),
        if (_showCustomGoalInput) ...[
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _goalController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your fitness goal',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  if (_goalController.text.isNotEmpty) {
                    setState(() {
                      _selectedGoals.add(_goalController.text);
                      _goalController.clear();
                    });
                  }
                },
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildDaysSelector() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _weekDays.map((day) {
        return FilterChip(
          label: Text(day),
          selected: _selectedDays.contains(day),
          onSelected: (selected) {
            setState(() {
              if (selected) {
                _selectedDays.add(day);
              } else {
                _selectedDays.remove(day);
              }
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildTimePreference() {
    return Wrap(
      children: _timePreferences.map((time) {
        return RadioListTile<String>(
          title: Text(time),
          value: time,
          groupValue: _preferredTime,
          onChanged: (value) {
            setState(() => _preferredTime = value!);
          },
        );
      }).toList(),
    );
  }

  Widget _buildEquipmentGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            // Predefined equipment
            ..._equipmentOptions.map((equipment) {
              final isSelected = _selectedEquipment.contains(equipment);
              return FilterChip(
                label: Text(equipment),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (equipment == 'Other') {
                      _showCustomEquipmentInput = selected;
                    }
                    if (selected) {
                      _selectedEquipment.add(equipment);
                    } else {
                      _selectedEquipment.remove(equipment);
                      if (equipment == 'Other') {
                        _showCustomEquipmentInput = false;
                      }
                    }
                  });
                },
              );
            }),
            // Custom equipment
            ..._selectedEquipment
                .where((equipment) => !_equipmentOptions.contains(equipment))
                .map((customEquipment) {
              return FilterChip(
                label: Text(customEquipment),
                selected: true,
                onSelected: (selected) {
                  setState(() {
                    if (!selected) {
                      _selectedEquipment.remove(customEquipment);
                    }
                  });
                },
              );
            }),
          ],
        ),
        if (_showCustomEquipmentInput) ...[
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _equipmentController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your equipment',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  if (_equipmentController.text.isNotEmpty) {
                    setState(() {
                      _selectedEquipment.add(_equipmentController.text);
                      _equipmentController.clear();
                    });
                  }
                },
              ),
            ],
          ),
        ],
      ],
    );
  }

  void _submitForm() {
    final preferences = TraineePreferences(
      fitnessGoals: _selectedGoals,
      availableDays: _selectedDays,
      preferredTrainingTime: _preferredTime,
      equipmentAccess: _selectedEquipment,
      dietaryRestrictions: [_dietaryController.text],
      lifestyle: Lifestyle(
        occupation: _occupationController.text,
        stressLevel: _stressLevel.round(),
        sleepHours: _sleepHours.round(),
      ),
    );
    widget.onNext(preferences);
  }

  @override
  void dispose() {
    _dietaryController.dispose();
    _occupationController.dispose();
    super.dispose();
  }
}

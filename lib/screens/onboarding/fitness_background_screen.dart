import 'package:flutter/material.dart';
import '../../data/models/trainee_profile.dart';

class FitnessBackgroundScreen extends StatefulWidget {
  final Function(FitnessBackground) onNext;
  final FitnessBackground? initialData;

  const FitnessBackgroundScreen({
    super.key,
    required this.onNext,
    this.initialData,
  });

  @override
  State<FitnessBackgroundScreen> createState() =>
      _FitnessBackgroundScreenState();
}

class _FitnessBackgroundScreenState extends State<FitnessBackgroundScreen> {
  late TrainingExperience _experienceLevel;
  late final List<String> _selectedActivities;
  late final TextEditingController _injuriesController;
  late double _activityLevel;

  @override
  void initState() {
    super.initState();
    _experienceLevel =
        widget.initialData?.experienceLevel ?? TrainingExperience.BEGINNER;
    _selectedActivities = widget.initialData?.previousActivities.toList() ?? [];
    _injuriesController =
        TextEditingController(text: widget.initialData?.injuries.join('\n'));
    _activityLevel = _getActivityLevelValue(
        widget.initialData?.currentActivityLevel ?? 'Moderate');
  }

  final List<String> _activityLevels = [
    'Sedentary',
    'Light',
    'Moderate',
    'Active',
    'Very Active'
  ];

  final List<String> _availableActivities = [
    'Running',
    'Swimming',
    'Weightlifting',
    'Yoga',
    'Cycling',
    'CrossFit',
    'Martial Arts',
    'Team Sports',
    'Dancing',
    'Pilates',
    'Other',
  ];

  final _otherActivityController = TextEditingController();
  bool _showOtherInput = false;
  final List<String> _injuries = [];
  final _injuryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness Background'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Experience Level Section
            const Text(
              'Experience Level',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildExperienceLevelSelector(),

            const SizedBox(height: 24),
            // Previous Activities Section
            const Text(
              'Previous Activities',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildActivitiesGrid(),

            const SizedBox(height: 24),
            const Text(
              'Previous Injuries',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Injuries Section
            _buildInjuriesSection(),

            const SizedBox(height: 24),
            // Current Activity Level Section
            const Text(
              'Current Activity Level',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildActivityLevelSlider(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: _submitForm,
          child: const Text('Next'),
        ),
      ),
    );
  }

  Widget _buildExperienceLevelSelector() {
    return Column(
      children: TrainingExperience.values.map((level) {
        return RadioListTile<TrainingExperience>(
          title: Text(level.toString().split('.').last),
          value: level,
          groupValue: _experienceLevel,
          onChanged: (TrainingExperience? value) {
            setState(() {
              _experienceLevel = value!;
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildActivitiesGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            // First show predefined activities
            ..._availableActivities.map((activity) {
              final isSelected = _selectedActivities.contains(activity);
              return FilterChip(
                label: Text(activity),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (activity == 'Other') {
                      _showOtherInput = selected;
                    }
                    if (selected) {
                      _selectedActivities.add(activity);
                    } else {
                      _selectedActivities.remove(activity);
                      if (activity == 'Other') {
                        _showOtherInput = false;
                      }
                    }
                  });
                },
              );
            }),
            // Then show custom activities
            ..._selectedActivities
                .where((activity) => !_availableActivities.contains(activity))
                .map((customActivity) {
              return FilterChip(
                label: Text(customActivity),
                selected: true,
                onSelected: (selected) {
                  setState(() {
                    if (!selected) {
                      _selectedActivities.remove(customActivity);
                    }
                  });
                },
              );
            }),
          ],
        ),
        if (_showOtherInput) ...[
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _otherActivityController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your activity',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  if (_otherActivityController.text.isNotEmpty) {
                    setState(() {
                      _selectedActivities.add(_otherActivityController.text);
                      _otherActivityController.clear();
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

  Widget _buildActivityLevelSlider() {
    return Column(
      children: [
        Slider(
          value: _activityLevel,
          min: 1,
          max: 5,
          divisions: 4,
          label: _getActivityLevelLabel(),
          onChanged: (value) {
            setState(() {
              _activityLevel = value;
            });
          },
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Sedentary'),
            Text('Very Active'),
          ],
        ),
      ],
    );
  }

  Widget _buildInjuriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _injuryController,
                decoration: const InputDecoration(
                  hintText: 'Enter injury or medical condition',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                if (_injuryController.text.isNotEmpty) {
                  setState(() {
                    _injuries.add(_injuryController.text);
                    _injuryController.clear();
                  });
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _injuries.map((injury) {
            return Chip(
              label: Text(injury),
              onDeleted: () {
                setState(() {
                  _injuries.remove(injury);
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  double _getActivityLevelValue(String level) {
    final index = _activityLevels.indexOf(level);
    // Convert to 1-based scale for slider
    return index == -1 ? 3.0 : (index + 1).toDouble();
  }

  String _getActivityLevelLabel() {
    // Convert slider value back to string label
    return _activityLevels[_activityLevel.round() - 1];
  }

  void _submitForm() {
    final fitnessBackground = FitnessBackground(
      experienceLevel: _experienceLevel,
      previousActivities: _selectedActivities,
      injuries: _injuries,
      currentActivityLevel: _getActivityLevelLabel(),
    );
    widget.onNext(fitnessBackground);
  }

  @override
  void dispose() {
    _injuriesController.dispose();
    super.dispose();
  }
}

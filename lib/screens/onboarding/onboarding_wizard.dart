import 'package:flutter/material.dart';
import '../../data/models/trainee_profile.dart';
import 'personal_info_screen.dart';
import 'health_metrics_screen.dart';
import 'fitness_background_screen.dart';
import 'trainee_preferences_screen.dart';

class OnboardingWizard extends StatefulWidget {
  const OnboardingWizard({super.key});

  @override
  State<OnboardingWizard> createState() => _OnboardingWizardState();
}

class _OnboardingWizardState extends State<OnboardingWizard> {
  int currentStep = 0;
  final int totalSteps = 4;

  // Data holders for each step
  PersonalInfo? personalInfo;
  FitnessBackground? fitnessBackground;
  HealthMetrics? healthMetrics;
  TraineePreferences? preferences;

  // Step completion tracking
  final List<bool> _completedSteps = List.generate(4, (_) => false);

  // Add debug flag
  static const bool _debugSkipEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Progress indicator
          LinearProgressIndicator(
            value: (currentStep + 1) / totalSteps,
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
          ),

          // Steps overview
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                  totalSteps, (index) => _buildStepIndicator(index)),
            ),
          ),

          // Add debug skip button when enabled
          if (_debugSkipEnabled) _buildDebugSkipButton(),

          // Current step content
          Expanded(
            child: _buildCurrentStep(),
          ),
        ],
      ),
    );
  }

  Widget _buildDebugSkipButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {
              setState(() {
                _markStepCompleted(currentStep);
                currentStep++;
              });
            },
            child: const Row(
              children: [
                Icon(Icons.fast_forward),
                SizedBox(width: 8),
                Text('DEV: Skip Step'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator(int step) {
    bool isCompleted = _completedSteps[step];
    bool isCurrent = currentStep == step;

    return GestureDetector(
      onTap: () => _navigateToStep(step),
      child: Column(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCompleted
                  ? Colors.green.shade500
                  : (isCurrent ? Colors.blue.shade500 : Colors.grey.shade200),
              border: Border.all(
                color: isCurrent ? Colors.blue.shade200 : Colors.transparent,
                width: 2,
              ),
              boxShadow: isCurrent
                  ? [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.3),
                        blurRadius: 8,
                        spreadRadius: 2,
                      )
                    ]
                  : null,
            ),
            child: Center(
              child: isCompleted
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : Text(
                      '${step + 1}',
                      style: TextStyle(
                        color: isCurrent ? Colors.white : Colors.grey.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _getStepTitle(step),
            style: TextStyle(
              fontSize: 12,
              color: isCurrent ? Colors.blue.shade500 : Colors.grey.shade600,
              fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  String _getStepTitle(int step) {
    switch (step) {
      case 0:
        return 'Personal';
      case 1:
        return 'Health';
      case 2:
        return 'Fitness';
      case 3:
        return 'Preferences';
      default:
        return '';
    }
  }

  void _navigateToStep(int step) {
    // Only allow navigation to completed steps or the current step
    if (step <= currentStep || _completedSteps[step]) {
      setState(() => currentStep = step);
    }
  }

  void _markStepCompleted(int step) {
    setState(() {
      _completedSteps[step] = true;
    });
  }

  Widget _buildCurrentStep() {
    switch (currentStep) {
      case 0:
        return PersonalInfoScreen(
          initialData: personalInfo, // Pass existing data if available
          onNext: (info) {
            setState(() {
              personalInfo = info;
              _markStepCompleted(0);
              currentStep++;
            });
          },
        );
      case 1:
        return HealthMetricsScreen(
          initialData: healthMetrics,
          onNext: (metrics) {
            setState(() {
              healthMetrics = metrics;
              _markStepCompleted(1);
              currentStep++;
            });
          },
        );
      case 2:
        return FitnessBackgroundScreen(
          initialData: fitnessBackground,
          onNext: (background) {
            setState(() {
              fitnessBackground = background;
              _markStepCompleted(2);
              currentStep++;
            });
          },
        );
      case 3:
        return TraineePreferencesScreen(
          initialData: preferences,
          onNext: (prefs) {
            setState(() {
              preferences = prefs;
              _markStepCompleted(3);
              currentStep++;
            });
          },
        );
      default:
        return _buildCompletionScreen();
    }
  }

  Widget _buildCompletionScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle, size: 64, color: Colors.green),
          const SizedBox(height: 16),
          const Text('Profile Setup Complete!'),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _submitProfile,
            child: const Text('Start Your Journey'),
          ),
        ],
      ),
    );
  }

  Future<void> _submitProfile() async {
    // Here we'll submit the complete profile
    final profile = TraineeProfile(
      id: DateTime.now().toString(), // Temporary ID generation
      personalInfo: personalInfo!,
      fitnessBackground: fitnessBackground!,
      healthMetrics: healthMetrics!,
      preferences: preferences!,
    );

    // Navigate to main app
    Navigator.pushReplacementNamed(context, '/main');
  }
}

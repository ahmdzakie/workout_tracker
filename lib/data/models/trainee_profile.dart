enum Gender { MALE, FEMALE, OTHER }
enum TrainingExperience { BEGINNER, INTERMEDIATE, ADVANCED }

class TraineeProfile {
  final String id;
  final PersonalInfo personalInfo;
  final FitnessBackground fitnessBackground;
  final HealthMetrics healthMetrics;
  final TraineePreferences preferences;

  TraineeProfile({
    required this.id,
    required this.personalInfo,
    required this.fitnessBackground,
    required this.healthMetrics,
    required this.preferences,
  });
}

class PersonalInfo {
  final String fullName;
  final DateTime dateOfBirth;
  final Gender gender;
  final String email;
  final String phone;
  final EmergencyContact emergencyContact;

  PersonalInfo({
    required this.fullName,
    required this.dateOfBirth,
    required this.gender,
    required this.email,
    required this.phone,
    required this.emergencyContact,
  });
}

class EmergencyContact {
  final String name;
  final String relationship;
  final String phone;

  EmergencyContact({
    required this.name,
    required this.relationship,
    required this.phone,
  });
}

class FitnessBackground {
  final TrainingExperience experienceLevel;
  final List<String> previousActivities;
  final List<String> injuries;
  final String currentActivityLevel;

  FitnessBackground({
    required this.experienceLevel,
    required this.previousActivities,
    required this.injuries,
    required this.currentActivityLevel,
  });
}

class HealthMetrics {
  final double height;
  final double weight;
  final BodyMeasurements bodyMeasurements;
  final int restingHeartRate;
  final BloodPressure bloodPressure;

  HealthMetrics({
    required this.height,
    required this.weight,
    required this.bodyMeasurements,
    required this.restingHeartRate,
    required this.bloodPressure,
  });
}

class BodyMeasurements {
  final double chest;
  final double waist;
  final double hips;
  final double arms;

  BodyMeasurements({
    required this.chest,
    required this.waist,
    required this.hips,
    required this.arms,
  });
}

class BloodPressure {
  final int systolic;
  final int diastolic;

  BloodPressure({
    required this.systolic,
    required this.diastolic,
  });
}

class TraineePreferences {
  final List<String> fitnessGoals;
  final List<String> availableDays;
  final String preferredTrainingTime;
  final List<String> equipmentAccess;
  final List<String> dietaryRestrictions;
  final Lifestyle lifestyle;

  TraineePreferences({
    required this.fitnessGoals,
    required this.availableDays,
    required this.preferredTrainingTime,
    required this.equipmentAccess,
    required this.dietaryRestrictions,
    required this.lifestyle,
  });
}

class Lifestyle {
  final String occupation;
  final int stressLevel;
  final int sleepHours;

  Lifestyle({
    required this.occupation,
    required this.stressLevel,
    required this.sleepHours,
  });
}

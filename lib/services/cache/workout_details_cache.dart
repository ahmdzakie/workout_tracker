import 'package:workout_tracker/models/workout_details.dart';

class WorkoutDetailsCache {
  final Map<int, WorkoutDetails> _cache = {};
  
  WorkoutDetails? get(int workoutId) => _cache[workoutId];
  
  void store(int workoutId, WorkoutDetails details) {
    _cache[workoutId] = details;
  }
  
  bool has(int workoutId) => _cache.containsKey(workoutId);
  
  List<int> getMissingIds(List<int> workoutIds) {
    return workoutIds.where((id) => !has(id)).toList();
  }

  void storeAll(List<WorkoutDetails> details) {
    for (final detail in details) {
      store(detail.id, detail);
    }
  }
}
import 'package:workout_tracker/services/api/workout_api_client.dart';
import 'package:workout_tracker/services/api/workout_plan_api_client.dart';
import 'package:workout_tracker/services/cache/workout_details_cache.dart';
import 'package:get_it/get_it.dart';


final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton(() => WorkoutDetailsCache());
  getIt.registerLazySingleton(() => WorkoutApiClient());
}

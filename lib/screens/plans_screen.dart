import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/workout_plan.dart';
import '../repositories/workout_plan_repository.dart';
import '../repositories/workout_plan_repository_impl.dart';
import '../services/api/workout_plan_api_client.dart';
import '../repositories/mock_workout_plan_repository.dart';
import 'day_detail_screen.dart';

class PlansScreen extends StatefulWidget {
  const PlansScreen({super.key});

  @override
  _PlansScreenState createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen> {
  final WorkoutPlanRepository workoutPlanRepository =
      // WorkoutPlanRepositoryImpl(WorkoutPlanApiClient());
      MockWorkoutPlanRepository();
  WorkoutPlan? currentPlan;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCurrentPlan();
  }

  Future<void> _loadCurrentPlan() async {
    try {
      final plan = await workoutPlanRepository.getCurrentPlan();
      print('Workout Plan Details:');
      print('Plan Name: ${plan.name}');
      print('Duration: ${plan.description} weeks');
      print('\nWorkouts:');
      var workout = plan.monday;
      //for (var workout in plan.friday) {
      print('\n${workout.name}:');
      print('Exercises:');
      for (var exercise in workout.exercises) {
        print(
            '- ${exercise.technique}: ${exercise.sets} sets, ${exercise.reps} reps');
      }
      //}
      setState(() {
        currentPlan = plan;
        isLoading = false;
      });
    } on Exception catch (error) {
      setState(() {
        isLoading = false;
      });
      print('Error loading plan: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              backgroundColor: Colors.transparent,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.blue[400]!,
                      Colors.blue[800]!,
                    ],
                  ),
                ),
                child: FlexibleSpaceBar(
                  centerTitle: false,
                  titlePadding: const EdgeInsets.only(left: 20, bottom: 60),
                  title: Text(
                    'Workout Plans',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  background: Stack(
                    children: [
                      Positioned(
                        right: -50,
                        top: -50,
                        child: CircleAvatar(
                          radius: 100,
                          backgroundColor: Colors.white.withOpacity(0.1),
                        ),
                      ),
                      Positioned(
                        left: -30,
                        bottom: -30,
                        child: CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.white.withOpacity(0.1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              bottom: TabBar(
                indicatorColor: Colors.white,
                indicatorWeight: 3,
                labelStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                ),
                tabs: const [
                  Tab(text: 'CURRENT PLAN'),
                  Tab(text: 'PREVIOUS PLANS'),
                ],
              ),
            ),
          ],
          body: isLoading
              ? const Center(child: CircularProgressIndicator())
              : TabBarView(
                  children: [
                    _buildCurrentPlan(),
                    _buildPreviousPlans(),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildCurrentPlan() {
    if (currentPlan == null) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      physics: const BouncingScrollPhysics(),
      itemCount: currentPlan!.getAllPlanDays().length,
      itemBuilder: (context, index) {
        final dayPlan = currentPlan!.getAllPlanDays()[index];
        return _buildDayCard(dayPlan);
      },
    );
  }

  Widget _buildDayCard(DayPlan dayPlan) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DayDetailScreen(dayPlan: dayPlan),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          Icons.fitness_center,
                          color: Colors.blue[400],
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dayPlan.name,
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${dayPlan.exercises.length} exercises',
                              style: GoogleFonts.poppins(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blue[400],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  if (dayPlan.exercises.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    _buildExercisePreview(dayPlan),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExercisePreview(DayPlan dayPlan) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: dayPlan.exercises
            .take(2)
            .map((exercise) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.fitness_center,
                          size: 12,
                          color: Colors.blue[700],
                        ),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        '${exercise.sets} sets × ${exercise.reps} reps',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildPreviousPlans() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      physics: const BouncingScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(20),
            leading: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                Icons.history,
                color: Colors.grey[600],
                size: 30,
              ),
            ),
            title: Text(
              'Previous Plan ${index + 1}',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            subtitle: Text(
              'Completed: ${2023 - index}',
              style: GoogleFonts.poppins(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            trailing: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                Icons.arrow_forward,
                color: Colors.grey[600],
                size: 20,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.fitness_center,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 20),
          Text(
            'No workout plan available',
            style: GoogleFonts.poppins(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

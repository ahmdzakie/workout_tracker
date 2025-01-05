import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/home_screen.dart';
import 'screens/plans_screen.dart';
import 'screens/diet_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/contact_screen.dart';
import 'screens/onboarding/onboarding_wizard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Precache your fonts
  await precacheFonts();
  runApp(const WorkoutTrackerApp());
}

Future<void> precacheFonts() async {
  final fontLoader = FontLoader('Roboto')
    ..addFont(rootBundle.load('fonts/Roboto-Regular.ttf'))
    ..addFont(rootBundle.load('fonts/Roboto-Bold.ttf'))
    ..addFont(rootBundle.load('fonts/Roboto-Light.ttf'));
  await fontLoader.load();
}

class WorkoutTrackerApp extends StatelessWidget {
  const WorkoutTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workout Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      // Replace home with initialRoute until the onboarding is complete
      // initialRoute: '/onboarding',
      // routes: {
      //   '/onboarding': (context) => const OnboardingWizard(),
      //   '/main': (context) => const MainScreen(),
      // },
      home: const MainScreen(),
    );
  }
}
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

    final List<Widget> _screens = [
    const HomeScreen(),
    const PlansScreen(),
    const DietScreen(),
    const ProfileScreen(),
    const ContactScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'Plans'),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu),label: 'Diet Plan'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.contact_support), label: 'Contact'),
        ],
      ),
    );
  }
}
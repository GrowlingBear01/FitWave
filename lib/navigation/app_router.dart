import 'package:flutter/material.dart';

import '../screens/splash_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/home_screen.dart';
import '../screens/goal_selection_screen.dart';
import '../screens/exercise_selection_screen.dart';
import '../screens/difficulty_screen.dart';
import '../screens/challenge_setup_screen.dart';
import '../screens/challenge_confirmation_screen.dart';
import '../screens/workout_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case '/goal-selection':
        return MaterialPageRoute(builder: (_) => const GoalSelectionScreen());

      case '/exercise-selection':
        return MaterialPageRoute(
          builder: (_) => const ExerciseSelectionScreen(),
        );

      case '/difficulty':
        return MaterialPageRoute(builder: (_) => const DifficultyScreen());

      case '/challenge-setup':
        return MaterialPageRoute(builder: (_) => const ChallengeSetupScreen());

      case '/challenge-confirmation':
        return MaterialPageRoute(
          builder: (_) => const ChallengeConfirmationScreen(),
        );

      case '/workout':
        return MaterialPageRoute(builder: (_) => const WorkoutScreen());

      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}

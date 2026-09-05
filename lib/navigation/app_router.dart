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
import '../screens/challenge_completion_screen.dart';

import '../screens/challenges_screen.dart';
import '../screens/progress_screen.dart';
import '../screens/wallet_screen.dart';
import '../screens/rewards_screen.dart';
import '../screens/streak_screen.dart';
import '../screens/notifications_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const SplashScreen(),
        );

      case '/login':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const LoginScreen(),
        );

      case '/register':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const RegisterScreen(),
        );

      case '/home':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const HomeScreen(),
        );

      case '/goal-selection':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const GoalSelectionScreen(),
        );

      case '/exercise-selection':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const ExerciseSelectionScreen(),
        );

      case '/difficulty':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const DifficultyScreen(),
        );

      case '/challenge-setup':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const ChallengeSetupScreen(),
        );

      case '/challenge-confirmation':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const ChallengeConfirmationScreen(),
        );

      case '/workout':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const WorkoutScreen(),
        );

      case '/challenge-completion':
        return MaterialPageRoute(
          builder: (_) => const ChallengeCompletionScreen(),
        );

      // ==========================================================
      // DAY 5 SCREENS
      // ==========================================================

      case '/challenges':
        return MaterialPageRoute(builder: (_) => const ChallengesScreen());

      case '/progress':
        return MaterialPageRoute(builder: (_) => const ProgressScreen());

      case '/wallet':
        return MaterialPageRoute(builder: (_) => const WalletScreen());

      case '/rewards':
        return MaterialPageRoute(builder: (_) => const RewardsScreen());

      case '/streak':
        return MaterialPageRoute(builder: (_) => const StreakScreen());

      case '/notifications':
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());

      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const SplashScreen(),
        );
    }
  }
}
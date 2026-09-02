# FitWave 🏋️‍♂️

FitWave is a Flutter-based fitness application designed to help users create fitness challenges, track their progress, and complete guided workouts with camera-assisted exercise monitoring.

## 🚀 Features

### 🔐 Authentication
- User registration
- User login
- Firebase Authentication
- Logout functionality
- Forgot password support

### 🎯 Challenge System
Users can create personalized fitness challenges by selecting:

- Goal
- Exercise
- Difficulty
- Duration

Available goals include:
- Build Strength
- Lose Weight
- Improve Fitness
- Stay Healthy

Available exercises include:
- Full Body
- Cardio
- Strength
- Yoga
- Core
- Stretching

Available difficulty levels:
- Beginner
- Intermediate
- Advanced

Challenge durations:
- 7 days
- 14 days
- 21 days
- 28 days

### ☁️ Firebase & Firestore
FitWave uses Firebase for backend services.

Challenge data stored in Firestore includes:
- User ID
- Goal
- Exercise
- Difficulty
- Duration
- Start date
- End date
- Status
- Progress
- Creation timestamp

### 🏃 Workout System
- Guided workout screen
- Workout timer
- Pause and resume
- Stop workout
- Workout completion flow
- Exit confirmation
- Camera-assisted workout interface

### 🤖 AI Workout Interface
The workout screen includes a camera interface designed for future/ongoing AI-based exercise form monitoring.

The camera feature is separated from the core workout functionality, so the workout timer can continue even when camera access is unavailable.

---

## 🛠️ Tech Stack

| Technology | Purpose |
|------------|---------|
| Flutter | Mobile/Desktop application framework |
| Dart | Programming language |
| Firebase Authentication | User authentication |
| Cloud Firestore | Database |
| Camera Plugin | Camera access and workout monitoring |
| Android Studio | Development environment |
| Git & GitHub | Version control and collaboration |

---

## 📁 Project Structure

```text
lib/
├── models/
│   └── challenge.dart
│
├── navigation/
│   └── app_router.dart
│
├── screens/
│   ├── splash_screen.dart
│   ├── login_screen.dart
│   ├── register_screen.dart
│   ├── home_screen.dart
│   ├── goal_selection_screen.dart
│   ├── exercise_selection_screen.dart
│   ├── difficulty_screen.dart
│   ├── challenge_setup_screen.dart
│   ├── challenge_confirmation_screen.dart
│   └── workout_screen.dart
│
├── services/
│   ├── auth_service.dart
│   ├── user_service.dart
│   └── challenge_service.dart
│
├── theme/
│   └── app_theme.dart
│
├── firebase_options.dart
└── main.dart
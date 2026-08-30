import 'package:firebase_auth/firebase_auth.dart';
import 'user_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserService _userService = UserService();

  Future<UserCredential> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final userCredential =
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = userCredential.user;

    if (user != null) {
      await _userService.createUserProfile(
        uid: user.uid,
        name: name,
        email: email,
      );
    }

    return userCredential;
  }

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;

  Future<void> resetPassword({
    required String email,
  }) async {
    await _auth.sendPasswordResetEmail(
      email: email,
    );
  }
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
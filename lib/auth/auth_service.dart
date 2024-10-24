import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // Instance of FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign in with email and password
  Future<UserCredential> signInWithEmailPassword(
      String email, String password) async {
    print('Attempting to sign in with email: $email');
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('Sign in successful for user: ${userCredential.user?.email}');
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print(
          'FirebaseAuthException: ${e.message}'); // Added logging for better error tracking
      // Handling common Firebase authentication errors
      switch (e.code) {
        case 'user-not-found':
          throw Exception('No user found for that email.');
        case 'wrong-password':
          throw Exception('Incorrect password.');
        case 'invalid-email':
          throw Exception('The email address is badly formatted.');
        case 'user-disabled':
          throw Exception('The user account has been disabled.');
        default:
          throw Exception('Error: ${e.code}');
      }
    } catch (e) {
      print('Unknown error occurred: $e');
      throw Exception('An unknown error occurred. Please try again.');
    }
  }

  // Sign up with email and password
  Future<UserCredential> signUpWithEmailPassword(
      String email, String password, String confirmPassword) async {
    // Check if password and confirmPassword match
    if (password != confirmPassword) {
      throw Exception('Passwords do not match.');
    }

    print('Attempting to sign up with email: $email');
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('Sign up successful for user: ${userCredential.user?.email}');
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print(
          'FirebaseAuthException: ${e.message}'); // Added logging for better error tracking
      // Handling common Firebase registration errors
      switch (e.code) {
        case 'email-already-in-use':
          throw Exception('The email address is already in use.');
        case 'invalid-email':
          throw Exception('The email address is badly formatted.');
        case 'weak-password':
          throw Exception('The password is too weak.');
        default:
          throw Exception('Error: ${e.code}');
      }
    } catch (e) {
      print('Unknown error occurred: $e');
      throw Exception('An unknown error occurred. Please try again.');
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      print('User signed out successfully.');
    } catch (e) {
      print('Sign out failed: $e');
      throw Exception('Sign out failed. Please try again.');
    }
  }

  // Get the currently signed-in user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Send email verification to the current user
  Future<void> sendEmailVerification() async {
    User? user = getCurrentUser();
    if (user != null && !user.emailVerified) {
      try {
        await user.sendEmailVerification();
        print('Verification email sent to ${user.email}.');
      } catch (e) {
        print('Failed to send email verification: $e');
        throw Exception('Failed to send email verification. Please try again.');
      }
    } else {
      throw Exception('No user signed in or email already verified.');
    }
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      print('Password reset email sent to $email.');
    } catch (e) {
      print('Failed to send password reset email: $e');
      throw Exception(
          'Failed to send password reset email. Please check the email and try again.');
    }
  }
}

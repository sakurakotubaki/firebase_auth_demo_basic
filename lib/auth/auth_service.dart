import 'package:firebase_auth/firebase_auth.dart';
import 'authj_exceptoin.dart';

class AuthService {
  // Singleton instance
  static final AuthService _instance = AuthService._internal();
  
  // Private constructor
  AuthService._internal();
  
  // Getter for the singleton instance
  static AuthService get instance => _instance;
  
  // Firebase Auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  // Current user getter
  User? get currentUser => _auth.currentUser;
  
  // Sign Up method
  Future<User?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      // Validate email format (basic check)
      if (!_isValidEmail(email)) {
        throw AuthjExceptoin.invalidEmail;
      }
      
      // Validate password length
      if (password.length < 6) {
        throw AuthjExceptoin.weakPassword;
      }
      
      // Attempt to create user
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw AuthjExceptoin.emailAlreadyInUse;
      }
      rethrow;
    }
  }
  
  // Sign In method
  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      // Validate email format (basic check)
      if (!_isValidEmail(email)) {
        throw AuthjExceptoin.invalidEmail;
      }
      
      // Attempt to sign in
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        throw AuthjExceptoin.invalidCredentials;
      }
      rethrow;
    }
  }
  
  // Sign Out method
  Future<void> signOut() async {
    await _auth.signOut();
  }
  
  // Basic email validation
  bool _isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegExp.hasMatch(email);
  }
}
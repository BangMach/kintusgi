import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:kintsugi/services/user_preferences.dart';

abstract class AuthBase {
  User get currentUser;
  List<AccessibilityMode> get accessibilityModes;

  void setAccessibilityMode(AccessibilityMode mode);

  Stream<User> authStateChanges();

  Future<User> signInWithEmailAndPassword({
    @required String email,
    @required String password,
  });
  Future<User> createUserWithEmailAndPassword({
    @required String email,
    @required String password,
  });

  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;
  List<AccessibilityMode> _accessibilityModes = [];

  @override
  User get currentUser => _firebaseAuth.currentUser;

  @override
  List<AccessibilityMode> get accessibilityModes => _accessibilityModes;

  @override
  void setAccessibilityMode(AccessibilityMode mode) {
    if (mode != AccessibilityMode.DYSLEXIA) {
      // If it does not yet exist, add it to the list
      if (!_accessibilityModes.contains(mode)) {
        _accessibilityModes.add(mode);
      } else {
        // If it already exists, remove it from the list
        _accessibilityModes.remove(mode);
      }
    }
  }

  @override
  Stream<User> authStateChanges() => _firebaseAuth.authStateChanges();

  @override
  Future<User> signInWithEmailAndPassword({
    @required String email,
    @required String password,
  }) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  @override
  Future<User> createUserWithEmailAndPassword({
    @required String email,
    @required String password,
  }) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}

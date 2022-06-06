// 📦 Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

enum AccessibilityMode {
  NONE,
  VISUAL,
  HEARING,
  ADHD,
  DYSLEXIA,
}

abstract class AuthBase {
  User get currentUser;
  AccessibilityMode get accessibilityMode;

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
  AccessibilityMode _accessibilityMode = AccessibilityMode.NONE;

  @override
  User get currentUser => _firebaseAuth.currentUser;

  @override
  AccessibilityMode get accessibilityMode => _accessibilityMode;

  @override
  void setAccessibilityMode(AccessibilityMode mode) {
    // Filter out invalid modes & Dyslexia
    if (mode != AccessibilityMode.DYSLEXIA) _accessibilityMode = mode;
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

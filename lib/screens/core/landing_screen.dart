import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kintsugi/core/navigation_wrapper.dart';
import 'package:kintsugi/screens/auth/auth_screen.dart';
import 'package:kintsugi/services/auth.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<User>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User user = snapshot.data;

          if (user == null) return AuthScreen.create(context);
          return NavigationWrapper();
        } else
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
      },
    );
  }
}

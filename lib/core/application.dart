// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:kintsugi/screens/core/landing_screen.dart';
import 'package:kintsugi/services/auth.dart';
import 'package:provider/provider.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (context) => Auth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.indigo,
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.indigoAccent),
        ),
        home: LandingScreen(),
      ),
    );
  }
}

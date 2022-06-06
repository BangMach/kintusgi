// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:kintsugi/screens/landing_screen.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.indigo,
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Colors.indigoAccent),
      ),
      home: LandingScreen(),
    );
  }
}

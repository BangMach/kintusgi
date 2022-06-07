// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:kintsugi/l10n/l10n.dart';
import 'package:kintsugi/screens/core/landing_screen.dart';
import 'package:kintsugi/services/auth.dart';
import 'package:provider/provider.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthBase>(
          create: (context) => Auth(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color.fromRGBO(255, 210, 51, 1),
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.indigo),
        ),
        // supportedLocales: L10n.all,
        home: LandingScreen(),
      ),
    );
  }
}

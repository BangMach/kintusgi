// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kintsugi/l10n/l10n.dart';
import 'package:kintsugi/screens/core/landing_screen.dart';
import 'package:kintsugi/services/auth.dart';
import 'package:kintsugi/services/locale_provider.dart';
import 'package:kintsugi/services/user_preferences.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LocaleProvider(),
      builder: (context, child) {
        final localeProvider = Provider.of<LocaleProvider>(context);

        return MultiProvider(
          providers: [
            Provider<AuthBase>(
              create: (context) => Auth(),
            ),
            Provider<UserReferences>(
              create: (context) => UserReferences(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: Color.fromRGBO(255, 210, 51, 1),
              colorScheme:
                  ColorScheme.fromSwatch().copyWith(secondary: Colors.indigo),
            ),
            supportedLocales: L10n.all,
            locale: localeProvider.locale,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            home: LandingScreen(),
          ),
        );
      },
    );
  }
}

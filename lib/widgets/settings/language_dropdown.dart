import 'package:flutter/material.dart';
import 'package:kintsugi/l10n/l10n.dart';
import 'package:kintsugi/services/locale_provider.dart';
import 'package:kintsugi/services/user_preferences.dart';
import 'package:provider/provider.dart';

class LanguageDropdown extends StatefulWidget {
  const LanguageDropdown({Key key}) : super(key: key);

  @override
  State<LanguageDropdown> createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  String getLanguageName(String languageCode) {
    switch (languageCode) {
      case 'en':
        return 'English';
      case 'vi':
        return 'Tiếng Việt';
      default:
        return 'English';
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final localeProvider = Provider.of<LocaleProvider>(context);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
        side: BorderSide(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButton<Locale>(
          value: locale,
          isExpanded: true,
          iconSize: 24,
          elevation: 16,
          underline: Container(
            height: 0,
          ),
          style: TextStyle(
            color: Colors.indigo,
            fontWeight: FontWeight.bold,
          ),
          onChanged: (Locale newValue) {
            localeProvider.setLocale(newValue);
          },
          items: L10n.all.map<DropdownMenuItem<Locale>>((Locale value) {
            return DropdownMenuItem<Locale>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Text(L10n.getFlag(value)),
                    SizedBox(width: 8),
                    Text(getLanguageName(value.languageCode)),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

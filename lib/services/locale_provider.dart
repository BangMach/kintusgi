import 'package:flutter/cupertino.dart';
import 'package:kintsugi/l10n/l10n.dart';
import 'package:kintsugi/services/resource_manager.dart';
import 'package:provider/provider.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale;

  Locale get locale => _locale;

  void setLocale(BuildContext context, Locale locale) async {
    if (!L10n.all.contains(locale)) return;
    _locale = locale;

    final resourceManager = Provider.of<ResourceManager>(
      context,
      listen: false,
    );

    resourceManager.updateLocale(locale);
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum TabItem { home, settings }

class TabItemData {
  const TabItemData({
    @required this.title,
    @required this.icon,
  });

  final String title;
  final IconData icon;

  static Map<TabItem, TabItemData> getAllTabs(BuildContext context) {
    return {
      TabItem.home: TabItemData(
        title: AppLocalizations.of(context).home,
        icon: Icons.home,
      ),
      TabItem.settings: TabItemData(
        title: AppLocalizations.of(context).settings,
        icon: Icons.settings,
      ),
    };
  }
}

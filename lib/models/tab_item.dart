import 'package:flutter/material.dart';

enum TabItem { home, settings }

class TabItemData {
  const TabItemData({
    @required this.title,
    @required this.icon,
  });

  final String title;
  final IconData icon;

  static const Map<TabItem, TabItemData> allTabs = {
    TabItem.home: TabItemData(
      title: 'Home',
      icon: Icons.home,
    ),
    TabItem.settings: TabItemData(
      title: 'Settings',
      icon: Icons.settings,
    ),
  };
}

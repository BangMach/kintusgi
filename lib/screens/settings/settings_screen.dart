import 'package:flutter/material.dart';
import 'package:kintsugi/core/constants.dart';
import 'package:kintsugi/services/auth.dart';
import 'package:kintsugi/services/resource_manager.dart';
import 'package:kintsugi/widgets/common/show_alert_dialog.dart';
import 'package:kintsugi/widgets/settings/language_dropdown.dart';
import 'package:kintsugi/widgets/settings/settings_group.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Future<void> _logOut(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final bool confirmedLogout = await showAlertDialog(context,
        title: AppLocalizations.of(context).logout,
        content: AppLocalizations.of(context).confirmContent,
        defaultActionText: AppLocalizations.of(context).confirmYes,
        cancelActionText: AppLocalizations.of(context).confirmNo);
    if (confirmedLogout) _logOut(context);
  }

  void selectAccessibilityMode(BuildContext context, AccessibilityMode mode) {
    final resourceManager = Provider.of<ResourceManager>(
      context,
      listen: false,
    );

    setState(() {
      resourceManager.toggleAccessibilityMode(mode);
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<AuthBase>(context).currentUser;
    final accessibilityModes =
        Provider.of<ResourceManager>(context).accessibilityModes;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context).settings),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              SettingsGroup(
                title: AppLocalizations.of(context).account,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          backgroundImage: currentUser.photoURL != null
                              ? NetworkImage(
                                  currentUser.photoURL,
                                )
                              : AssetImage(
                                  'assets/core/user_placeholder.png',
                                ),
                          radius: 40,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const SizedBox(height: 8.0),
                              Text(
                                currentUser.email,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                children: <Widget>[
                                  // Expanded(
                                  //   child: ElevatedButton(
                                  //     child: Text('Edit profile'),
                                  //     onPressed: () {},
                                  //     style: ButtonStyle(
                                  //       backgroundColor:
                                  //           MaterialStateProperty.all(
                                  //         Colors.indigo,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  Expanded(
                                    child: ElevatedButton(
                                      child: Text(
                                        AppLocalizations.of(context).logout,
                                      ),
                                      onPressed: () => _confirmSignOut(context),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          Colors.indigo,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SettingsGroup(
                title: AppLocalizations.of(context).generalSettings,
                children: <Widget>[
                  LanguageDropdown(),
                  // Card(
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(4.0),
                  //     side: BorderSide(
                  //       color: Colors.grey,
                  //       width: 1.0,
                  //     ),
                  //   ),
                  //   child: ListTile(
                  //     title: Text(
                  //       'Theme',
                  //       style: Theme.of(context).textTheme.button,
                  //     ),
                  //     subtitle: Text('Light'),
                  //     trailing: Icon(Icons.keyboard_arrow_right),
                  //   ),
                  // ),
                  // Card(
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(4.0),
                  //     side: BorderSide(
                  //       color: Colors.grey,
                  //       width: 1.0,
                  //     ),
                  //   ),
                  //   child: ListTile(
                  //     title: Text(
                  //       'Font Size',
                  //       style: Theme.of(context).textTheme.button,
                  //     ),
                  //     subtitle: Text('Medium'),
                  //     trailing: Icon(Icons.keyboard_arrow_right),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(height: 16),
              SettingsGroup(
                title: AppLocalizations.of(context).accessibilityLabel,
                children: [
                  GestureDetector(
                    onTap: () => selectAccessibilityMode(
                      context,
                      AccessibilityMode.VISUAL,
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        side: accessibilityModes
                                .contains(AccessibilityMode.VISUAL)
                            ? BorderSide(
                                color: Colors.indigo,
                                width: 2.0,
                              )
                            : BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                      ),
                      child: ListTile(
                        title: Text(
                          AppLocalizations.of(context).visualImpairment,
                          style: Theme.of(context).textTheme.button,
                        ),
                        subtitle: Text(
                          AppLocalizations.of(context).visualImpairment,
                        ),
                        trailing: accessibilityModes
                                .contains(AccessibilityMode.VISUAL)
                            ? Icon(
                                Icons.check_box,
                                color: Colors.green,
                                size: 30.0,
                              )
                            : Icon(
                                Icons.check_box_outline_blank_rounded,
                                color: Colors.grey,
                                size: 30.0,
                              ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => selectAccessibilityMode(
                      context,
                      AccessibilityMode.HEARING,
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        side: accessibilityModes
                                .contains(AccessibilityMode.HEARING)
                            ? BorderSide(
                                color: Colors.indigo,
                                width: 2.0,
                              )
                            : BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 16.0,
                        ),
                        child: ListTile(
                          title: Text(
                            AppLocalizations.of(context).hearingImpairment,
                            style: Theme.of(context).textTheme.button,
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Text(
                              AppLocalizations.of(context).hearingImpairmentDes,
                            ),
                          ),
                          trailing: accessibilityModes
                                  .contains(AccessibilityMode.HEARING)
                              ? Icon(
                                  Icons.check_box,
                                  color: Colors.green,
                                  size: 30.0,
                                )
                              : Icon(
                                  Icons.check_box_outline_blank_rounded,
                                  color: Colors.grey,
                                  size: 30.0,
                                ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => selectAccessibilityMode(
                      context,
                      AccessibilityMode.ADHD,
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        side:
                            accessibilityModes.contains(AccessibilityMode.ADHD)
                                ? BorderSide(
                                    color: Colors.indigo,
                                    width: 2.0,
                                  )
                                : BorderSide(
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical:
                              Localizations.localeOf(context).languageCode ==
                                      'vi'
                                  ? 16.0
                                  : 0.0,
                        ),
                        child: ListTile(
                          title: Text(
                            AppLocalizations.of(context).adhd,
                            style: Theme.of(context).textTheme.button,
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Text(AppLocalizations.of(context).adhdDes),
                          ),
                          trailing: accessibilityModes
                                  .contains(AccessibilityMode.ADHD)
                              ? Icon(
                                  Icons.check_box,
                                  color: Colors.green,
                                  size: 30.0,
                                )
                              : Icon(
                                  Icons.check_box_outline_blank_rounded,
                                  color: Colors.grey,
                                  size: 30.0,
                                ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => selectAccessibilityMode(
                      context,
                      AccessibilityMode.DYSLEXIA,
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        side: accessibilityModes
                                .contains(AccessibilityMode.DYSLEXIA)
                            ? BorderSide(
                                color: Colors.indigo,
                                width: 2.0,
                              )
                            : BorderSide(
                                color: Colors.orangeAccent,
                                width: 2.0,
                              ),
                      ),
                      child: ListTile(
                        title: Text(
                          AppLocalizations.of(context).dyslexia,
                          style: Theme.of(context).textTheme.button,
                        ),
                        subtitle: Text(
                          AppLocalizations.of(context).dyslexiaDes,
                          style: TextStyle(
                            color: Colors.orange[700],
                          ),
                        ),
                        trailing: Icon(
                          Icons.warning,
                          color: Colors.orangeAccent,
                          size: 30.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              SettingsGroup(
                title: AppLocalizations.of(context).membership,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      side: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        AppLocalizations.of(context).membershipStandard,
                        style: Theme.of(context).textTheme.button,
                      ),
                      subtitle: Text(
                          AppLocalizations.of(context).membershipStandardDes),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      side: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        AppLocalizations.of(context).membershipPremium,
                        style: Theme.of(context).textTheme.button,
                      ),
                      subtitle: Text(
                        AppLocalizations.of(context).membershipPremiumDes,
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      side: BorderSide(
                        color: Colors.indigo,
                        width: 2.0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                      ),
                      child: ListTile(
                        title: Text(
                          AppLocalizations.of(context).membershipEnterpirse,
                          style: Theme.of(context).textTheme.button,
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: Text(
                            AppLocalizations.of(context)
                                .membershipEnterpirseDes,
                          ),
                        ),
                        trailing: Icon(
                          Icons.check_box,
                          color: Colors.green,
                          size: 30.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              SettingsGroup(
                title: AppLocalizations.of(context).applicationSettings,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => showAboutDialog(
                      context: context,
                      applicationName: 'Accesstant',
                      applicationLegalese: '© 2022 Kintsugi Team',
                      applicationVersion: APP_VERSION,
                      applicationIcon: Image.asset(
                        'assets/core/circular-logo.png',
                        width: 75,
                      ),
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        side: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: ListTile(
                        title: Text(
                          AppLocalizations.of(context).aboutOurApp,
                          style: Theme.of(context).textTheme.button,
                        ),
                        subtitle: Text('Accesstant v$APP_VERSION'),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => showLicensePage(
                      context: context,
                      applicationName: 'Accesstant',
                      applicationLegalese: '© 2022 Kintsugi Team',
                      applicationVersion: APP_VERSION,
                      applicationIcon: Image.asset(
                        'assets/core/circular-logo.png',
                        width: 75,
                      ),
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        side: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: ListTile(
                        title: Text(
                          AppLocalizations.of(context).applicationLicenses,
                          style: Theme.of(context).textTheme.button,
                        ),
                        subtitle: Text(
                          AppLocalizations.of(context).applicationLicensesDes,
                        ),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text.rich(
                TextSpan(
                  text: AppLocalizations.of(context).madeWithLoveBy + ' ',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                  children: <InlineSpan>[
                    TextSpan(
                      text: 'Kintsugi',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

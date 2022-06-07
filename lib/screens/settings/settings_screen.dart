import 'package:flutter/material.dart';
import 'package:kintsugi/services/auth.dart';
import 'package:kintsugi/services/user_preferences.dart';
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
  Future<void> _signOut(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final bool didRequestSignOut = await showAlertDialog(
      context,
      title: 'Confirmation',
      content: 'Are you sure you want to logout?',
      defaultActionText: 'Logout',
      cancelActionText: 'Cancel',
    );
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  void selectAccessibilityMode(BuildContext context, AccessibilityMode mode) {
    final references = Provider.of<UserReferences>(context, listen: false);
    setState(() {
      references.setAccessibilityMode(mode);
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<AuthBase>(context).currentUser;
    final accessibilityModes =
        Provider.of<UserReferences>(context).accessibilityModes;

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
                title: 'Account',
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: currentUser.photoURL != null
                              ? NetworkImage(
                                  currentUser.photoURL,
                                )
                              : NetworkImage(
                                  'https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png'),
                          radius: 40,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                currentUser.email,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
                                  // const SizedBox(width: 8),
                                  Expanded(
                                    child: ElevatedButton(
                                      child: Text('Logout'),
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
                title: 'General',
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
                      child: ListTile(
                        title: Text(
                          AppLocalizations.of(context).hearingImpairment,
                          style: Theme.of(context).textTheme.button,
                        ),
                        subtitle: Text(
                          'Adjust experiences for hearing impaired',
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
                      child: ListTile(
                        title: Text(
                          'ADHD',
                          style: Theme.of(context).textTheme.button,
                        ),
                        subtitle: Text('Adjust experiences for ADHD users'),
                        trailing:
                            accessibilityModes.contains(AccessibilityMode.ADHD)
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
                          'Dyslexia',
                          style: Theme.of(context).textTheme.button,
                        ),
                        subtitle: Text(
                          'In development',
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
                title: 'Membership',
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
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
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      side: BorderSide(
                        color: Colors.indigo,
                        width: 2.0,
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        AppLocalizations.of(context).membershipEnterpirse,
                        style: Theme.of(context).textTheme.button,
                      ),
                      subtitle: Text(
                        AppLocalizations.of(context).membershipEnterpirseDes,
                      ),
                      trailing: Icon(
                        Icons.check_box,
                        color: Colors.green,
                        size: 30.0,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text.rich(
                TextSpan(
                  text: 'Made with ❤️ by ',
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

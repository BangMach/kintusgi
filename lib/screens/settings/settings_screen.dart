import 'package:flutter/material.dart';
import 'package:kintsugi/core/constants.dart';
import 'package:kintsugi/services/auth.dart';
import 'package:kintsugi/widgets/common/show_alert_dialog.dart';
import 'package:kintsugi/widgets/settings/settings_group.dart';
import 'package:provider/provider.dart';

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
    final auth = Provider.of<AuthBase>(context, listen: false);
    setState(() {
      auth.setAccessibilityMode(mode);
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<AuthBase>(context).currentUser;
    final accessibilityMode = Provider.of<AuthBase>(context).accessibilityMode;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Settings'),
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
                                  Expanded(
                                    child: ElevatedButton(
                                      child: Text('Edit profile'),
                                      onPressed: () {},
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: ElevatedButton(
                                      child: Text('Logout'),
                                      onPressed: () => _confirmSignOut(context),
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
                        'Languages',
                        style: Theme.of(context).textTheme.button,
                      ),
                      subtitle: Text('English'),
                      trailing: Icon(Icons.keyboard_arrow_right),
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
                        'Theme',
                        style: Theme.of(context).textTheme.button,
                      ),
                      subtitle: Text('Light'),
                      trailing: Icon(Icons.keyboard_arrow_right),
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
                        'Font Size',
                        style: Theme.of(context).textTheme.button,
                      ),
                      subtitle: Text('Medium'),
                      trailing: Icon(Icons.keyboard_arrow_right),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              SettingsGroup(
                title: 'Accessibility assistant',
                children: [
                  GestureDetector(
                    onTap: () => selectAccessibilityMode(
                      context,
                      AccessibilityMode.VISUAL,
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        side: accessibilityMode == AccessibilityMode.VISUAL
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
                          'Visual Impairment',
                          style: Theme.of(context).textTheme.button,
                        ),
                        subtitle:
                            Text('Adjust experiences for visually impaired'),
                        trailing: accessibilityMode == AccessibilityMode.VISUAL
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
                        side: accessibilityMode == AccessibilityMode.HEARING
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
                          'Hearing Impairment',
                          style: Theme.of(context).textTheme.button,
                        ),
                        subtitle: Text(
                          'Adjust experiences for hearing impaired',
                        ),
                        trailing: accessibilityMode == AccessibilityMode.HEARING
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
                        side: accessibilityMode == AccessibilityMode.ADHD
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
                        trailing: accessibilityMode == AccessibilityMode.ADHD
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
                        side: accessibilityMode == AccessibilityMode.DYSLEXIA
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
                          'Dyslexia',
                          style: Theme.of(context).textTheme.button,
                        ),
                        subtitle: Text('In development'),
                        trailing: Icon(
                          Icons.auto_fix_high_outlined,
                          color: Colors.indigo,
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
                        'Standard',
                        style: Theme.of(context).textTheme.button,
                      ),
                      subtitle: Text('Limited access to all assissants'),
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
                        'Premium',
                        style: Theme.of(context).textTheme.button,
                      ),
                      subtitle: Text(
                          'Unlimited access for one assistant, and limited access to all other assistants'),
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
                        'Enterprise',
                        style: Theme.of(context).textTheme.button,
                      ),
                      subtitle: Text(
                        'Unlimited access to all assistants',
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
              Text(
                'Version ' + APP_VERSION,
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

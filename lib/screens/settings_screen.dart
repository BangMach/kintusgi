import 'package:flutter/material.dart';
import 'package:kintsugi/core/constants.dart';
import 'package:kintsugi/widgets/settings/settings_group.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key key}) : super(key: key);
  final isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
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
                                isLoggedIn ? 'John Doe' : 'Guest',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: isLoggedIn
                                        ? ElevatedButton(
                                            child: Text('Edit profile'),
                                            onPressed: () {},
                                          )
                                        : ElevatedButton(
                                            child: Text('Login'),
                                            onPressed: () {},
                                          ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: isLoggedIn
                                        ? ElevatedButton(
                                            child: Text('Logout'),
                                            onPressed: () {},
                                          )
                                        : ElevatedButton(
                                            child: Text('Register'),
                                            onPressed: () {},
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
              SizedBox(height: 16),
              SettingsGroup(
                title: 'General',
                children: <Widget>[
                  Card(
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
                  Card(
                    child: ListTile(
                      title: Text(
                        'Visual Impairment',
                        style: Theme.of(context).textTheme.button,
                      ),
                      subtitle:
                          Text('Adjust experiences for visually impaired'),
                      trailing: Icon(
                        Icons.check_box_outline_blank_rounded,
                        color: Colors.grey,
                        size: 30.0,
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
                        'Hearing Impairment',
                        style: Theme.of(context).textTheme.button,
                      ),
                      subtitle: Text(
                        'Adjust experiences for hearing impaired',
                      ),
                      trailing: Icon(
                        Icons.check_box,
                        color: Colors.green,
                        size: 30.0,
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text(
                        'ADHD',
                        style: Theme.of(context).textTheme.button,
                      ),
                      subtitle: Text('Adjust experiences for ADHD users'),
                      trailing: Icon(
                        Icons.check_box_outline_blank_rounded,
                        color: Colors.grey,
                        size: 30.0,
                      ),
                    ),
                  ),
                  Card(
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

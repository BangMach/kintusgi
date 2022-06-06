import 'package:flutter/material.dart';
import 'package:kintsugi/screens/voice_recognizer_screen.dart';

class AccessibilitySelector extends StatelessWidget {
  const AccessibilitySelector({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Accessibility Selector'),
        backgroundColor: Colors.indigo,
      ),
      body: ButtonTypesExample(),
    );
  }
}

class ButtonTypesExample extends StatelessWidget {
  const ButtonTypesExample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: const <Widget>[
          Spacer(),
          ButtonTypesGroup(enabled: true),
          Spacer(),
        ],
      ),
    );
  }
}

class ButtonTypesGroup extends StatelessWidget {
  const ButtonTypesGroup({Key key, this.enabled}) : super(key: key);

  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "What\'s your condition?",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              // height: 4,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 300.0,
            height: 50,
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return VoiceRecognizer();
                }));
              },
              child: const Text(
                'Visual Impairment',
                style: TextStyle(
                  color: Colors.indigo,
                  fontSize: 20,
                ),
              ),
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    side: BorderSide(
                      color: Colors.indigo,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 300.0,
            height: 50,
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return VoiceRecognizer();
                }));
              },
              child: const Text(
                'Hearing Impairment',
                style: TextStyle(
                  color: Colors.indigo,
                  fontSize: 20,
                ),
              ),
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    side: BorderSide(
                      color: Colors.indigo,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 300.0, // <-- match_parent
            height: 50, // <
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return VoiceRecognizer();
                    },
                  ),
                );
              },
              child: const Text(
                'ADHD',
                style: TextStyle(
                  color: Colors.indigo,
                  fontSize: 20,
                ),
              ),
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    side: BorderSide(
                      color: Colors.indigo,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 300.0,
            height: 50,
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return VoiceRecognizer();
                }));
              },
              child: const Text(
                'Dyslexia',
                style: TextStyle(
                  color: Colors.indigo,
                  fontSize: 20,
                ),
              ),
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    side: BorderSide(
                      color: Colors.indigo,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 300.0,
            height: 50,
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return VoiceRecognizer();
                }));
              },
              child: const Text(
                'None of the above',
                style: TextStyle(
                  color: Colors.indigo,
                  fontSize: 20,
                ),
              ),
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    side: BorderSide(
                      color: Colors.indigo,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

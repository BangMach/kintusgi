import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kintsugi/screens/voice_recognizer_screen.dart';
import 'package:kintsugi/services/resource_manager.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccessibilitySelector extends StatelessWidget {
  const AccessibilitySelector({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context).accessibilitySelector),
        backgroundColor: Colors.indigo,
      ),
      body: ButtonTypesGroup(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        padding: EdgeInsets.all(20.0),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => VoiceRecognizer(),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.chevron_right,
                  color: Colors.transparent,
                  size: 32.0,
                ),
                Text(
                  AppLocalizations.of(context).proceed,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                  size: 32.0,
                ),
              ],
            ),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.indigo),
          ),
        ),
      ),
    );
  }
}

class ButtonTypesGroup extends StatefulWidget {
  const ButtonTypesGroup({Key key, this.enabled}) : super(key: key);

  final bool enabled;

  @override
  State<ButtonTypesGroup> createState() => _ButtonTypesGroupState();
}

class _ButtonTypesGroupState extends State<ButtonTypesGroup> {
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
    final accessibilityModes =
        Provider.of<ResourceManager>(context).accessibilityModes;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 32.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            AppLocalizations.of(context).accessibilitySelectorDescription,
            style: TextStyle(
              color: Colors.indigo,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 32.0,
          ),
          GestureDetector(
            onTap: () => selectAccessibilityMode(
              context,
              AccessibilityMode.VISUAL,
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
                side: accessibilityModes.contains(AccessibilityMode.VISUAL)
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
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ListTile(
                  title: Text(
                    AppLocalizations.of(context).visualImpairment,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing:
                      accessibilityModes.contains(AccessibilityMode.VISUAL)
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
          SizedBox(height: 8.0),
          GestureDetector(
            onTap: () => selectAccessibilityMode(
              context,
              AccessibilityMode.HEARING,
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
                side: accessibilityModes.contains(AccessibilityMode.HEARING)
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
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ListTile(
                  title: Text(
                    AppLocalizations.of(context).hearingImpairment,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing:
                      accessibilityModes.contains(AccessibilityMode.HEARING)
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
          SizedBox(height: 8.0),
          GestureDetector(
            onTap: () => selectAccessibilityMode(
              context,
              AccessibilityMode.ADHD,
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
                side: accessibilityModes.contains(AccessibilityMode.ADHD)
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
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ListTile(
                  title: Text(
                    AppLocalizations.of(context).adhd,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: accessibilityModes.contains(AccessibilityMode.ADHD)
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
          // SizedBox(
          //   width: 300.0,
          //   height: 50,
          //   child: OutlinedButton(
          //     onPressed: () {
          //       Navigator.push(context, MaterialPageRoute(builder: (context) {
          //         return VoiceRecognizer();
          //       }));
          //     },
          //     child: const Text(
          //       'None of the above',
          //       style: TextStyle(
          //         color: Colors.indigo,
          //         fontSize: 20,
          //       ),
          //     ),
          //     style: ButtonStyle(
          //       shape: MaterialStateProperty.all(
          //         RoundedRectangleBorder(
          //           borderRadius: BorderRadius.all(Radius.circular(10.0)),
          //           side: BorderSide(
          //             color: Colors.indigo,
          //             width: 2,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

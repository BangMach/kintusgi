import 'package:flutter/material.dart';
import 'package:kintsugi/widgets/forms/validation_form.dart';

class AccessibilitySelector extends StatelessWidget {
  const AccessibilitySelector({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          //ButtonTypesGroup(enabled: false),
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
    GlobalKey _LogInState = GlobalKey();

    final VoidCallback onPressed = enabled ? () {} : null;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        key: _LogInState,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "Tình Trạng của bạn là gì",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              // height: 4,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            width: 300.0, // <-- match_parent
            height: 50, // <
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(_LogInState.currentContext,
                    MaterialPageRoute(builder: (context) {
                  return FormValidation();
                }));
              },
              child: const Text(
                'Khiếm thị',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 300.0, // <-- match_parent
            height: 50, // <
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(_LogInState.currentContext,
                    MaterialPageRoute(builder: (context) {
                  return FormValidation();
                }));
              },
              child: const Text(
                'Khiếm thính',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
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
                  _LogInState.currentContext,
                  MaterialPageRoute(
                    builder: (context) {
                      return FormValidation();
                    },
                  ),
                );
              },
              child: const Text(
                'Rối loạn tăng động, giảm chú ý',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 300.0, // <-- match_parent
            height: 50, // <
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(_LogInState.currentContext,
                    MaterialPageRoute(builder: (context) {
                  return FormValidation();
                }));
              },
              child: const Text(
                'Chứng khó đọc (đang phát triển',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 300.0, // <-- match_parent
            height: 50, //
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(_LogInState.currentContext,
                    MaterialPageRoute(builder: (context) {
                  return FormValidation();
                }));
              },
              child: const Text(
                'Không có khiếm khuyết',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

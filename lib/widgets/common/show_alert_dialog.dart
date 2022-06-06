// 🎯 Dart imports:
import 'dart:io';

// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<bool> showAlertDialog(
  BuildContext context, {
  @required String title,
  @required String content,
  @required String defaultActionText,
  String cancelActionText,
}) async {
  bool _cancel = false;
  if (Platform.isIOS) {
    await showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: title != null ? Text(title) : null,
          content: content != null ? Text(content) : null,
          actions: <Widget>[
            if (cancelActionText != null)
              CupertinoDialogAction(
                onPressed: () {
                  _cancel = true;
                  Navigator.of(context).pop();
                },
                child: Text(cancelActionText),
              ),
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(defaultActionText),
            ),
          ],
        );
      },
    );
    return !_cancel;
  } else {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: title != null ? Text(title) : null,
          content: content != null ? Text(content) : null,
          actions: <Widget>[
            if (cancelActionText != null)
              TextButton(
                onPressed: () {
                  _cancel = true;
                  Navigator.of(context).pop();
                },
                child: Text(cancelActionText),
              ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(defaultActionText),
            ),
          ],
        );
      },
    );
    return !_cancel;
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kintsugi/widgets/common/show_alert_dialog.dart';

Future<void> showExceptionAlertDialog(
  BuildContext context, {
  String title = 'Something went wrong.',
  @required Exception exception,
}) =>
    showAlertDialog(
      context,
      title: title,
      content: _message(exception),
      defaultActionText: 'Proceed',
    );

String _message(Exception exception) {
  if (exception is FirebaseException) return exception.message;
  return exception.toString();
}

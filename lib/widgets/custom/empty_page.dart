// 🐦 Flutter imports:
import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({
    Key key,
    this.title = 'There\'s nothing here.',
    this.message = '',
  }) : super(key: key);

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 32.0,
              color: Colors.black54,
            ),
          ),
          Text(
            message,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

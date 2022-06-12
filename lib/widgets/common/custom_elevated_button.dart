// 🐦 Flutter imports:
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key key,
    this.child,
    this.color,
    this.minimized: false,
    this.height: 50.0,
    this.borderRadius: 8.0,
    this.onPressed,
  }) : super(key: key);

  final Widget child;
  final Color color;
  final bool minimized;
  final double height;
  final double borderRadius;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: minimized ? height : null,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        ),
        child: child,
      ),
    );
  }
}

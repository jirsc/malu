import 'package:flutter/material.dart';

typedef _FullWidthButtonCallback = dynamic Function();

class FullWidthButton extends StatelessWidget {
  const FullWidthButton(
    this.buttonText, {
    Key? key,
    required this.onPressed,
    this.textColor = Colors.black87,
    this.color = Colors.white,
    this.enabled = true,
    this.border = BorderSide.none,
    this.elevation = 0,
  }) : super(key: key);

  final String buttonText;
  final Color textColor;
  final Color color;
  final bool enabled;
  final BorderSide border;
  final _FullWidthButtonCallback onPressed;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 43,
        child: TextButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
              side: border,
            ),
            primary: enabled ? color : Colors.grey.shade400,
            elevation: elevation,
          ),
          onPressed: onPressed,
          Widget: Text(
            buttonText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ));
  }
}

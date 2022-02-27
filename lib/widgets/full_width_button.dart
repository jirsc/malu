import 'package:doeat/core/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef _FullWidthButtonCallback = dynamic Function();

class FullWidthButton extends StatelessWidget {
  const FullWidthButton(this.buttonText,
      {Key? key,
      required this.onPressed,
      this.textColor = Colors.black87,
      this.color = Colors.white,
      this.disabled = false,
      this.border = BorderSide.none})
      : super(key: key);

  final String buttonText;
  final Color textColor;
  final Color color;
  final bool disabled;
  final BorderSide border;
  final _FullWidthButtonCallback onPressed;

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
            primary: disabled ? Colors.grey.shade400 : color,
          ),
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ));
  }
}

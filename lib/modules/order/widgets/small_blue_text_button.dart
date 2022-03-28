import 'package:flutter/material.dart';

typedef _CustomButtonCallback = dynamic Function();

class SmallBlueTextButton extends StatelessWidget {
  const SmallBlueTextButton(
    this.text, {
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final _CustomButtonCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 11,
          color: Colors.blue,
        ),
      ),
      onTap: onPressed,
    );
  }
}

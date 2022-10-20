import 'package:flutter/material.dart';
import 'package:malu/config/config.dart';

typedef _ConfirmButtonCallback = dynamic Function();

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.cancelButtonText,
    required this.confirmButtonText,
    required this.onConfirm,
  }) : super(key: key);

  final String title;
  final String content;
  final String cancelButtonText;
  final String confirmButtonText;
  final _ConfirmButtonCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      //buttonPadding: EdgeInsets.symmetric(horizontal: 12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
              side: const BorderSide(width: 1, color: Colors.black87),
            ),
            primary: Colors.white,
            elevation: 0,
          ),
          child: Text(
            cancelButtonText,
            style: const TextStyle(
              color: Colors.black87,
            ),
          ),
        ),
        TextButton(
          onPressed: onConfirm,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
              side: BorderSide.none,
            ),
            primary: theme.primaryColor,
            elevation: 0,
          ),
          child: Text(
            confirmButtonText,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

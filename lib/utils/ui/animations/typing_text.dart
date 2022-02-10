import 'package:flutter/material.dart';

class TypingText extends AnimatedWidget {
  final String string;

  const TypingText(
      {required this.string, Key? key, required Listenable animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<int>;
    return Text(
      string.substring(0, animation.value),
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey[600],
      ),
    );
  }
}

/* class TypingTextList extends AnimatedWidget {
  final List<String> list;

  const TypingTextList(
      {required this.list, Key? key, required Listenable animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<int>;
    return Text(
      string.substring(0, animation.value),
      style: TextStyle(
        fontSize: 13,
        color: Colors.grey[600],
      ),
    );
  }
}
 */
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class TypingTextV2 extends StatelessWidget {
  const TypingTextV2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(animatedTexts: _getList());
  }
}

List<AnimatedText> _getList() {
  return [
    TyperAnimatedText(
      "responsive web and mobile app.",
      speed: const Duration(milliseconds: 300),
    ),
    TyperAnimatedText(
      "complete e-Commerce app UI.",
      speed: const Duration(milliseconds: 300),
    ),
    TyperAnimatedText(
      "Chat app with dark and light theme.",
      speed: const Duration(milliseconds: 300),
    ),
  ];
}

class TypingText2 extends AnimatedText {
  TypingText2({
    required this.textToAnimate,
    required this.speed,
  }) : super(text: textToAnimate, duration: speed);

  final String textToAnimate;
  final Duration speed;

  @override
  Widget animatedBuilder(BuildContext context, Widget? child) {
    // TODO: implement animatedBuilder
    throw UnimplementedError();
  }

  @override
  void initAnimation(AnimationController controller) {
    // TODO: implement initAnimation
  }
}

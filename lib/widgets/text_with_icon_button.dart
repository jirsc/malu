import 'package:flutter/material.dart';

typedef _TextWithIconButtonCallback = dynamic Function();

class TextWithIconButton extends StatelessWidget {
  const TextWithIconButton(this.text,
      {Key? key,
      required this.onPressed,
      this.color = const Color(0xFFffffff),
      this.padding = EdgeInsets.zero,
      this.icon = const Icon(Icons.add_circle),
      this.image,
      this.isIconImage = false,
      this.border = BorderSide.none})
      : super(key: key);

  final Text text;
  final Color color;
  final EdgeInsets padding;
  final Icon icon;
  final Image? image;
  final bool isIconImage;
  final BorderSide border;
  final _TextWithIconButtonCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 43,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          primary: color,
        ),
        onPressed: onPressed,
        child: Container(
          alignment: Alignment.centerLeft,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: padding,
                  child: isIconImage && image != null ? image : icon),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(alignment: Alignment.center, child: text),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

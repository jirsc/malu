import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class WidgetSizeListener extends StatefulWidget {
  final Widget child;
  final Function onChange;

  const WidgetSizeListener({
    Key? key,
    required this.onChange,
    required this.child,
  }) : super(key: key);

  @override
  _WidgetSizeListenerState createState() => _WidgetSizeListenerState();
}

class _WidgetSizeListenerState extends State<WidgetSizeListener> {
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance?.addPostFrameCallback(postFrameCallback);
    return Container(
      key: widgetKey,
      child: widget.child,
    );
  }

  var widgetKey = GlobalKey();
  var oldSize;

  void postFrameCallback(_) {
    var context = widgetKey.currentContext;
    if (context == null) return;

    var newSize = context.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    widget.onChange(newSize);
  }
}

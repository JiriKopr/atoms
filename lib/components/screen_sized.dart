import 'package:flutter/material.dart';

/// This widget takes whole size of the screen,
/// it is just workaround when there is some widget
/// that requires [Size] but your widget tree is composed
/// only from flexible widgets
class ScreenSized extends StatelessWidget {
  final Widget child;

  const ScreenSized({@required this.child, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width: size.width,
      child: child,
    );
  }
}

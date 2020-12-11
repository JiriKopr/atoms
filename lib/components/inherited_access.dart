import 'package:flutter/material.dart';

/// General Inherited widget, which stores provided value
/// and makes it accessible in widget tree.
/// Useful for example with [PageView], where we need to access
/// the [PageController] from pages them selves.
/// This way there is no need to pass the controller through constructor
class InheritedAccess<T> extends InheritedWidget {
  final Widget child;
  final T access;

  InheritedAccess({
    Key key,
    @required this.child,
    @required this.access,
  }) : super(key: key, child: child);

  static InheritedAccess<S> of<S>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedAccess<S>>();
  }

  @override
  bool updateShouldNotify(InheritedAccess oldWidget) {
    return this.access != oldWidget.access;
  }
}

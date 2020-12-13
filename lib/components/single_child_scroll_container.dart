import 'package:flutter/material.dart';

/// When there is an input on the page, it is
/// very likely there will be some overflow when
/// keyboard opens. If the page is wrapped with this
/// widget, whole page will just scroll, accordingly
/// NOTE: This is not usable in page with app bar
/// because the MediaQuery will take the height of whole
/// screen with app bar causing the page body to scroll.
class SingleChildScrollContainer extends StatelessWidget {
  final Widget child;
  const SingleChildScrollContainer({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: child,
      ),
    );
  }
}

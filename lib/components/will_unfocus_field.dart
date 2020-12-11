import 'package:flutter/material.dart';

/// This widget will unfocus
/// whatever input field is currently focused and
/// effectively close shown keyboard or click outside of
/// the input field
class WillUnfocusField extends StatelessWidget {
  final Widget child;

  const WillUnfocusField({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // When user clicks away from input the keyboard should close
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: child,
    );
  }
}

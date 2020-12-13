import 'package:flutter/material.dart';

/// This filed will focus the next input
/// on the keyboard action button click
class OutlineTextField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final TextInputType keyboardType;
  final bool focusNext;
  final TextEditingController controller;
  final Function onComplete;
  final String suffixText;

  const OutlineTextField({
    Key key,
    @required this.labelText,
    @required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.focusNext = true,
    this.suffixText,
    this.onComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      textInputAction: focusNext ? TextInputAction.next : TextInputAction.done,
      onEditingComplete: () {
        onComplete?.call();

        if (focusNext) {
          node.nextFocus();
        } else {
          node.unfocus();
        }
      },
      decoration: InputDecoration(
        labelText: labelText,
        suffixText: suffixText,
        border: OutlineInputBorder(),
      ),
    );
  }
}

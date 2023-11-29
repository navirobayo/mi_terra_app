import 'package:flutter/material.dart';

//! Template of a customized widget that manages the text for the action button.

class CustomTextForActionButtonWidget extends StatelessWidget {
  const CustomTextForActionButtonWidget({
    super.key,
    required this.text,
    required this.context,
  });

  final String text;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Theme.of(context).colorScheme.surface,
        fontSize: 15,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class FieldRefreshButton extends StatelessWidget {
  const FieldRefreshButton({
    required this.onPressed,
    this.height = 20,
    super.key,
  });

  final double height;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      iconSize: height,
      visualDensity: VisualDensity.compact,
      icon: const Icon(Icons.refresh),
    );
  }
}

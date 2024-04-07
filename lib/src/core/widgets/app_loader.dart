import 'package:flutter/material.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({
    this.height = 20,
    this.width = 20,
    super.key,
  });

  static const double _strokeWidth = 2;

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.secondary;

    return SizedBox(
      height: height,
      width: width,
      child: CircularProgressIndicator(
        color: color,
        strokeWidth: _strokeWidth,
      ),
    );
  }
}

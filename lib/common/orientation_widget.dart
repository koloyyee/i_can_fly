import 'package:flutter/material.dart';

class OrientationWidget extends StatelessWidget {
  final Widget portraitChild;
  final Widget landscapeChild;

  const OrientationWidget({
    super.key,
    required this.portraitChild,
    required this.landscapeChild,
  });

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return portraitChild;
        } else {
          return landscapeChild;
        }
      },
    );
  }
}

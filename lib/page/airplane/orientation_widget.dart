import 'package:flutter/material.dart';

class OrientationWidget extends StatelessWidget {
  final Widget portraitChild;
  final Widget landscapeChild;

  const OrientationWidget({
    Key? key,
    required this.portraitChild,
    required this.landscapeChild,
  }) : super(key: key);

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

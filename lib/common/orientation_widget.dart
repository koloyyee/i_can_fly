import 'package:flutter/material.dart';

/// A widget that provides different layouts based on the device orientation.
///
/// The `OrientationWidget` class is a stateless widget that displays
/// different child widgets depending on whether the device is in portrait
/// or landscape orientation.
/// Properties:
/// - `portraitChild`: The widget to display when the device is in portrait orientation.
/// - `landscapeChild`: The widget to display when the device is in landscape orientation.

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
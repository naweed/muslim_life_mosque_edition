import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/padding_extensions.dart';

class LoadingIndicator extends StatelessWidget {
  final Color indicatorColor;

  const LoadingIndicator({super.key, required this.indicatorColor});

  @override
  Widget build(BuildContext context) => Padding(
    padding: 48.withAllPadding(),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [SpinKitFadingCube(color: indicatorColor, size: 48)],
      ),
    ),
  );
}

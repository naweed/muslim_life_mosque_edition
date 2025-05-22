import 'package:flutter/material.dart';

enum LineStyle { Horizontal, Vertical }

class LineSeparater extends StatelessWidget {
  final LineStyle lineStyle;
  final Color lineColor;
  final double lineOpacity;

  const LineSeparater({super.key, required this.lineStyle, required this.lineColor, this.lineOpacity = 0.35});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: lineStyle == LineStyle.Vertical ? 1 : double.infinity,
      height: lineStyle == LineStyle.Horizontal ? 1 : double.infinity,
      color: lineColor.withValues(alpha: lineOpacity),
    );
  }
}

class SliverLineSeparater extends StatelessWidget {
  final LineStyle lineStyle;
  final Color lineColor;
  final double lineOpacity;

  const SliverLineSeparater({super.key, required this.lineStyle, required this.lineColor, this.lineOpacity = 0.35});

  @override
  Widget build(BuildContext context) =>
      SliverToBoxAdapter(child: LineSeparater(lineStyle: lineStyle, lineColor: lineColor, lineOpacity: lineOpacity));
}

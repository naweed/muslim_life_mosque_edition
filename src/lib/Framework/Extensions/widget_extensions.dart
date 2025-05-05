import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  Widget expandWidget({int flex = 1}) => Expanded(flex: flex, child: this);
}

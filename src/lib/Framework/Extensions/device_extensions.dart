import 'package:flutter/material.dart';

extension DeviceEntension on BuildContext {
  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

  Size get deviceSize => MediaQuery.of(this).size;
}

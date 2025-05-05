import 'package:flutter/material.dart';

extension StringExtensions on String {
  Color toColor() {
    var hexString = this;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String toCleanCacheKey() => replaceAll(RegExp(r'[\\~#%&*{}/:<>?|\"-]'), ' ').replaceAll(RegExp(r'\s+'), '_');

  bool toBoolean([bool strict = false]) {
    if (strict == true) {
      return this == '1' || this == 'true';
    }

    return this != '0' && this != 'false' && this != '';
  }
}

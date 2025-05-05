import 'package:flutter/material.dart';

extension NavigationExtensions on BuildContext {
  Future<dynamic> push(Widget page) async => Navigator.push(this, MaterialPageRoute(builder: (_) => page));

  Future<dynamic> pushReplacement(Widget page) async =>
      Navigator.pushAndRemoveUntil(this, MaterialPageRoute(builder: (_) => page), (route) => false);
  Future<dynamic> pushCurrentReplacement(Widget page) async =>
      Navigator.pushReplacement(this, MaterialPageRoute(builder: (_) => page));

  Future<dynamic> pop(Widget page, [result]) async => Navigator.of(this).pop(result);

  void popBottomSheet() async => Navigator.pop(this);
  void popPage() async => Navigator.pop(this);

  Future<dynamic> showBottomSheet(
    Widget child, {
    bool isScrollControlled = true,
    Color? backgroundColor,
    Color? barrierColor,
  }) => showModalBottomSheet(
    context: this,
    barrierColor: barrierColor,
    isScrollControlled: isScrollControlled,
    backgroundColor: backgroundColor,
    builder: (context) => Wrap(children: [child]),
  );

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(String message) =>
      ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message), behavior: SnackBarBehavior.floating));
}

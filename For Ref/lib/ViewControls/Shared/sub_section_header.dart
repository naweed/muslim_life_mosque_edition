import 'package:flutter/material.dart';
import 'package:muslimlife/Shared/app_styles.dart';

class SubSectionHeader extends StatelessWidget {
  final String text;

  const SubSectionHeader({super.key, required this.text});

  @override
  Widget build(BuildContext context) => Text(text, style: AppStyles.BoldDark16TextStyle);
}

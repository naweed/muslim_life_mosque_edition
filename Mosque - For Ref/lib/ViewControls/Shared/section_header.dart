import 'package:flutter/material.dart';
import 'package:muslimlife/Shared/app_styles.dart';

class SectionHeader extends StatelessWidget {
  final String text;

  const SectionHeader({super.key, required this.text});

  @override
  Widget build(BuildContext context) => Text(text, style: AppStyles.BoldDark20TextStyle);
}

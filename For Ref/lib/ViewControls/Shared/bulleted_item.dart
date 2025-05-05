import 'package:flutter/material.dart';
import 'package:muslimlife/Shared/app_styles.dart';

class BulettedList extends StatelessWidget {
  final String headerText;
  final String bodyText;

  const BulettedList({super.key, required this.headerText, required this.bodyText});

  @override
  Widget build(BuildContext context) => RichText(
    text: TextSpan(
      text: '\u2022 ',
      style: AppStyles.BoldDark16TextStyle.copyWith(height: 1.3),
      children: <TextSpan>[
        TextSpan(text: '$headerText: ', style: AppStyles.RegularDark14TextStyle.copyWith(height: 1.3)),
        TextSpan(text: bodyText, style: AppStyles.BoldDark14TextStyle.copyWith(height: 1.3)),
      ],
    ),
  );
}

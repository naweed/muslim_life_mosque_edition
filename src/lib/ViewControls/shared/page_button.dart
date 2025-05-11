import 'package:flutter/material.dart';
import 'package:muslim_life_mosque_edition/Shared/app_styles.dart';

class PageButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final bool isEnabled;

  const PageButton({super.key, required this.text, required this.onPressed, this.isEnabled = true});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: AppStyles.PageButtonStyle,
        child: Text(text, style: AppStyles.PageButtonTextStyle),
      ),
    );
  }
}

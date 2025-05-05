import 'package:flutter/material.dart';
import 'package:muslim_life_mosque_edition/Shared/app_styles.dart';

class LinkButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final bool isEnabled;

  const LinkButton({super.key, required this.text, required this.onPressed, this.isEnabled = true});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: AppStyles.LinkButtonStyle,
        child: Text(text, style: AppStyles.LinkButtonTextStyle),
      ),
    );
  }
}

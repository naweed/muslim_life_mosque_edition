import 'package:flutter/material.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/device_extensions.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/padding_extensions.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/sized_box_extensions.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/string_extensions.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/widget_extensions.dart';
import 'package:muslim_life_mosque_edition/Models/onboarding_content.dart';
import 'package:muslim_life_mosque_edition/Shared/app_styles.dart';

class OnboardingContentWidget extends StatelessWidget {
  final OnboardingContent model;

  const OnboardingContentWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: (144, 0, 144, 36).withLTRBPadding(),
      width: double.infinity,
      height: double.infinity,
      color: model.backgroundColor.toColor(),
      child: SizedBox(
        height: context.height * 0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(model.image, height: context.height * 0.4).expandWidget(flex: 3),
            Column(
              children: [
                Text(model.title, style: AppStyles.OnboardingTitleTextStyle, textAlign: TextAlign.center),
                12.toVerticalSpacer(),
                Text(
                  model.description,
                  style: AppStyles.OnboardingSubTitleTextStyle.copyWith(height: 1.25),
                  textAlign: TextAlign.center,
                ),
              ],
            ).expandWidget(flex: 2),
          ],
        ),
      ),
    );
  }
}

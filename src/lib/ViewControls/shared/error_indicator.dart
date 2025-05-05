import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/padding_extensions.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/sized_box_extensions.dart';
import 'package:muslim_life_mosque_edition/Shared/app_assets.dart';
import 'package:muslim_life_mosque_edition/Shared/app_styles.dart';

class ErrorIndicator extends StatelessWidget {
  final String errorText;

  const ErrorIndicator({super.key, required this.errorText});

  @override
  Widget build(BuildContext context) => Padding(
    padding: (64, 48).withSymetricPadding(),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 360, height: 360, child: SvgPicture.asset(AppAssets.ErrorImage, height: 240)),
          16.toVerticalSpacer(),
          const Text("Uh-Oh!", style: AppStyles.IndicatorHeaderTextStyle, textAlign: TextAlign.center),
          Text(errorText, style: AppStyles.IndicatorTextStyle, textAlign: TextAlign.center),
        ],
      ),
    ),
  );
}

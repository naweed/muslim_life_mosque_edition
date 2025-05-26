import 'package:flutter/material.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/padding_extensions.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/sized_box_extensions.dart';
import 'package:muslim_life_mosque_edition/Shared/app_colors.dart';
import 'package:muslim_life_mosque_edition/Shared/app_styles.dart';

class PrayerDisplayCell extends StatelessWidget {
  final String prayerName;
  final String prayerTime;
  final String iqamaTime;
  bool isCurrent;
  bool isNext;

  PrayerDisplayCell({
    super.key,
    required this.prayerName,
    required this.prayerTime,
    required this.iqamaTime,
    required this.isCurrent,
    required this.isNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 124,
      width: 136,
      decoration: BoxDecoration(
        color: isNext
            ? AppColors.PrayerBoxYellowColor.withValues(alpha: 0.15)
            : AppColors.PrayerBoxDarkColor.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isNext ? AppColors.PrayerBoxActiveBorderColor : AppColors.PrayerBoxInactiveBorderColor,
          width: isNext ? 2 : 1,
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (isNext)
            Positioned(
              top: -12,
              right: 12,
              child: Container(
                padding: (10, 4).withSymetricPadding(),
                decoration: BoxDecoration(color: AppColors.PrayerBoxNextColor, borderRadius: BorderRadius.circular(20)),
                child: const Text('NEXT', style: AppStyles.BoldDark10TextStyle),
              ),
            ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                6.toVerticalSpacer(),
                Text(
                  prayerName.toUpperCase(),
                  style: AppStyles.MediumLight14TextStyle.copyWith(
                    color: isNext ? AppColors.PrayerBoxYellowColor : AppColors.LightTextColor,
                  ),
                ),
                2.toVerticalSpacer(),
                Text(
                  prayerTime,
                  style: AppStyles.YellowExtraBold28TextStyle.copyWith(
                    color: isNext ? AppColors.LightYellowTextColor : AppColors.LightTextColor,
                  ),
                ),
                2.toVerticalSpacer(),
                Text(
                  iqamaTime == "N/A" ? "☀️" : "Iqama: $iqamaTime",
                  style: AppStyles.RegularLight14TextStyle.copyWith(
                    color: isNext ? AppColors.PrayerBoxYellowColor : AppColors.LightTextColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

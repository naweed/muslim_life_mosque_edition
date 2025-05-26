import 'package:flutter/material.dart';
import 'package:muslim_life_mosque_edition/Shared/app_colors.dart';

class PrayerDisplayCell extends StatelessWidget {
  final String prayerName;
  final DateTime prayerTime;
  bool isCurrent;
  bool isNext;

  PrayerDisplayCell({
    super.key,
    required this.prayerName,
    required this.prayerTime,
    required this.isCurrent,
    required this.isNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 108,
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
      child: Text(prayerName),
    );
  }
}

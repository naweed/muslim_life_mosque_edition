import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:muslimlife/Framework/Extensions/padding_extensions.dart';
import 'package:muslimlife/Framework/Extensions/sized_box_extensions.dart';
import 'package:muslimlife/Shared/app_colors.dart';
import 'package:muslimlife/Shared/app_styles.dart';

class PrayerStatsCell extends StatelessWidget {
  final bool isDark;
  final String text;
  final int prayerCount;
  final int totalPrayerCount;

  const PrayerStatsCell({
    super.key,
    required this.isDark,
    required this.text,
    required this.prayerCount,
    required this.totalPrayerCount,
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: (12, 10).withSymetricPadding(),
    decoration: BoxDecoration(
      color: !isDark ? Colors.white.withValues(alpha: 0.9) : AppColors.AppPrimaryColor,
      borderRadius: BorderRadius.circular(12),
      //border: Border.all(color: AppColors.AppPrimaryColor.withValues(alpha: 0.6), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //Header
        Text(
          text,
          style: isDark ? AppStyles.BoldLight12TextStyle : AppStyles.BoldDark12TextStyle,
          textAlign: TextAlign.center,
        ),

        //Spacer
        12.toVerticalSpacer(),

        //Graph
        DashedCircularProgressBar.square(
          dimensions: 66,
          progress: (360.0 * prayerCount.toDouble()) / (totalPrayerCount == 0 ? 1 : totalPrayerCount),
          maxProgress: 360,
          startAngle: -180,
          foregroundColor: isDark ? AppColors.LightGreenColor : AppColors.AppPrimaryColor,
          backgroundColor: isDark ? Colors.white.withValues(alpha: 0.4) : Colors.grey.withValues(alpha: 0.5),
          foregroundStrokeWidth: 6,
          backgroundStrokeWidth: 3,
          foregroundGapSize: 0,
          foregroundDashSize: 1,
          backgroundGapSize: 0,
          backgroundDashSize: 1,
          animation: false,
          child: Center(
            child: Text(
              "${prayerCount * 100 ~/ (totalPrayerCount == 0 ? 1 : totalPrayerCount)}%",
              style: isDark ? AppStyles.BoldLight14TextStyle : AppStyles.BoldDark14TextStyle,
            ),
          ),
        ),

        //Spacer
        8.toVerticalSpacer(),

        //Prayers Count
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              prayerCount.toString(),
              style: isDark ? AppStyles.BoldLight14TextStyle : AppStyles.BoldDark14TextStyle,
            ),
            Text(" of ", style: isDark ? AppStyles.RegularLight10TextStyle : AppStyles.RegularDark10TextStyle),
            Text(
              totalPrayerCount.toString(),
              style: isDark ? AppStyles.BoldLight14TextStyle : AppStyles.BoldDark14TextStyle,
            ),
          ],
        ),
      ],
    ),
  );
}

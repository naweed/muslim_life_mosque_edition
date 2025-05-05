import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:muslimlife/Framework/Extensions/padding_extensions.dart';
import 'package:muslimlife/Framework/Extensions/sized_box_extensions.dart';
import 'package:muslimlife/Shared/app_assets.dart';
import 'package:muslimlife/Shared/app_colors.dart';
import 'package:muslimlife/Shared/app_styles.dart';

class PrayerDisplayCell extends StatelessWidget {
  final String prayerName;
  final DateTime prayerTime;
  bool isPrayed;
  bool isCurrent;

  final void Function() onTap;

  PrayerDisplayCell({
    super.key,
    required this.prayerName,
    required this.prayerTime,
    required this.isPrayed,
    required this.isCurrent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: (16, 0, 8, 0).withLTRBPadding(),
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isCurrent ? AppColors.AppPrimaryColor : AppColors.DarkGrayColor.withValues(alpha: 0.00),
          width: isCurrent ? 1.5 : 0,
        ),
        color: isCurrent ? AppColors.LightGreenColor : AppColors.LightGreenColor.withValues(alpha: 0.6),
      ),
      width: double.infinity,
      //height: 72,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Prayer Name
          Text(prayerName, style: AppStyles.BoldDark16TextStyle),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Prayer Time
              Text(
                DateFormat('hh:mm a').format(prayerTime),
                style: AppStyles.MediumDark14TextStyle.copyWith(color: AppColors.DarkGrayColor.withValues(alpha: 0.85)),
              ),

              //Spacer
              20.toHorizontalSpacer(),

              //Is Prayed Status
              Visibility(
                visible: prayerName != "Sunrise",
                child: InkWell(
                  splashFactory: NoSplash.splashFactory,
                  onTap: onTap,
                  child: Container(
                    padding: 8.withAllPadding(),
                    child: SvgPicture.asset(
                      AppAssets.CheckboxIcon,
                      height: 28,
                      colorFilter: ColorFilter.mode(
                        isPrayed ? AppColors.AppPrimaryColor : AppColors.DarkGrayColor.withValues(alpha: 0.6),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),

              //Sunrise Icon
              Visibility(
                visible: prayerName == "Sunrise",
                child: Container(
                  padding: 5.withAllPadding(),
                  child: SvgPicture.asset(AppAssets.SunriseIcon, height: 36),
                ),
              ),
            ],
          ),
        ],
      ).withLTRBPadding(8, 0, 8, 0),
    );
  }
}

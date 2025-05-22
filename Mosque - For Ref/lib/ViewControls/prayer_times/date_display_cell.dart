import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:muslimlife/Framework/Extensions/padding_extensions.dart';
import 'package:muslimlife/Shared/app_assets.dart';
import 'package:muslimlife/Shared/app_colors.dart';
import 'package:muslimlife/Shared/app_styles.dart';

class DateDisplayCell extends StatelessWidget {
  final DateTime gregDate;
  final String hijriDate;
  final bool canScrollBack;
  final bool canScrollForward;
  final void Function() onNextTapped;
  final void Function() onPrevTapped;

  const DateDisplayCell({
    super.key,
    required this.gregDate,
    required this.hijriDate,
    required this.canScrollBack,
    required this.canScrollForward,
    required this.onNextTapped,
    required this.onPrevTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: (4, 0).withSymetricPadding(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        //border: Border.all(color: AppColors.DarkGrayColor.withValues(alpha: 0.05)),
        color: Colors.white.withValues(alpha: 0.9),
      ),
      width: double.infinity,
      child: Stack(
        children: [
          //Dates
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(DateFormat('EEEE').format(gregDate), style: AppStyles.MediumDark14TextStyle),
                //2.toVerticalSpacer(),
                Text(DateFormat('MMMM d, yyyy').format(gregDate), style: AppStyles.BoldDark20TextStyle),
                //2.toVerticalSpacer(),
                Text(hijriDate, style: AppStyles.RegularDark14TextStyle),
              ],
            ),
          ),

          //Prev Icon
          Align(
            alignment: Alignment.centerLeft,
            child: Visibility(
              visible: canScrollBack,
              child: GestureDetector(
                onTap: onPrevTapped,
                child: SvgPicture.asset(
                  AppAssets.BackArrowIcon,
                  height: 48,
                  colorFilter: ColorFilter.mode(AppColors.AppPrimaryColor.withValues(alpha: .8), BlendMode.srcIn),
                ),
              ),
            ),
          ),

          //Next Icon
          Align(
            alignment: Alignment.centerRight,
            child: Visibility(
              visible: canScrollForward,
              child: GestureDetector(
                onTap: onNextTapped,
                child: SvgPicture.asset(
                  AppAssets.ForwardArrowIcon,
                  height: 48,
                  colorFilter: ColorFilter.mode(AppColors.AppPrimaryColor.withValues(alpha: 0.8), BlendMode.srcIn),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

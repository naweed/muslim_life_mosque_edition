import 'package:flutter/material.dart';
import 'package:muslim_life_mosque_edition/Shared/app_colors.dart';

class AppStyles {
  // Text Styles

  //Yellow Extra Bold Text Styles
  static const TextStyle YellowExtraBold48TextStyle = TextStyle(
    fontFamily: "ExtraBoldFont",
    color: AppColors.YellowTextColor,
    fontSize: 48,
  );
  static const TextStyle YellowExtraBold36TextStyle = TextStyle(
    fontFamily: "ExtraBoldFont",
    color: AppColors.YellowTextColor,
    fontSize: 36,
  );
  static const TextStyle YellowExtraBold32TextStyle = TextStyle(
    fontFamily: "ExtraBoldFont",
    color: AppColors.YellowTextColor,
    fontSize: 32,
  );
  static const TextStyle YellowExtraBold28TextStyle = TextStyle(
    fontFamily: "ExtraBoldFont",
    color: AppColors.YellowTextColor,
    fontSize: 28,
  );

  //Yellow Medium Styles
  static const TextStyle YellowMedium14TextStyle = TextStyle(
    fontFamily: "MediumFont",
    color: AppColors.YellowTextColor,
    fontSize: 14,
  );

  //Yellow Regular Styles
  static const TextStyle YellowRegular16TextStyle = TextStyle(
    fontFamily: "RegularFont",
    color: AppColors.YellowTextColor,
    fontSize: 16,
  );

  //Regular Light Text Styles
  static const TextStyle RegularLight10TextStyle = TextStyle(
    fontFamily: "RegularFont",
    color: AppColors.LightTextColor,
    fontSize: 10,
  );
  static const TextStyle RegularLight14TextStyle = TextStyle(
    fontFamily: "RegularFont",
    color: AppColors.LightTextColor,
    fontSize: 14,
  );
  static const TextStyle RegularLight16TextStyle = TextStyle(
    fontFamily: "RegularFont",
    color: AppColors.LightTextColor,
    fontSize: 16,
  );
  static const TextStyle RegularLight18TextStyle = TextStyle(
    fontFamily: "RegularFont",
    color: AppColors.LightTextColor,
    fontSize: 18,
  );

  //Regular Dark Text Styles
  static const TextStyle RegularDark16TextStyle = TextStyle(
    fontFamily: "RegularFont",
    color: AppColors.DarkTextColor,
    fontSize: 16,
  );

  //Medium Light Text Styles
  static const TextStyle MediumLight24TextStyle = TextStyle(
    fontFamily: "MediumFont",
    color: AppColors.LightTextColor,
    fontSize: 24,
  );
  static const TextStyle MediumLight20TextStyle = TextStyle(
    fontFamily: "MediumFont",
    color: AppColors.LightTextColor,
    fontSize: 20,
  );
  static TextStyle MediumLighter18TextStyle = TextStyle(
    fontFamily: "MediumFont",
    color: AppColors.LightTextColor.withValues(alpha: 0.6),
    fontSize: 18,
  );
  static const TextStyle MediumLight18TextStyle = TextStyle(
    fontFamily: "MediumFont",
    color: AppColors.LightTextColor,
    fontSize: 18,
  );
  static const TextStyle MediumLight16TextStyle = TextStyle(
    fontFamily: "MediumFont",
    color: AppColors.LightTextColor,
    fontSize: 16,
  );
  static const TextStyle MediumLight14TextStyle = TextStyle(
    fontFamily: "MediumFont",
    color: AppColors.LightTextColor,
    fontSize: 14,
  );
  static const TextStyle MediumLight12TextStyle = TextStyle(
    fontFamily: "MediumFont",
    color: AppColors.LightTextColor,
    fontSize: 12,
  );

  //Medium Dark Text Styles
  static const TextStyle MediumDark24TextStyle = TextStyle(
    fontFamily: "MediumFont",
    color: AppColors.DarkTextColor,
    fontSize: 24,
  );

  //Bold Dark Text Styles
  static const TextStyle BoldDark10TextStyle = TextStyle(
    fontFamily: "BoldFont",
    color: AppColors.DarkTextColor,
    fontSize: 10,
  );

  //Other Text Styles
  static const TextStyle ToastTextStyle = TextStyle(
    fontFamily: "MediumFont",
    color: AppColors.LightTextColor,
    fontSize: 16,
  );
  static const TextStyle IndicatorTextStyle = TextStyle(
    fontFamily: "ExtraLightFont",
    color: AppColors.DarkTextColor,
    fontSize: 18,
    height: 1.25,
  );
  static const TextStyle IndicatorHeaderTextStyle = TextStyle(
    fontFamily: "RegularFont",
    color: AppColors.DarkTextColor,
    fontSize: 24,
  );
  static const TextStyle OnboardingTitleTextStyle = TextStyle(
    fontFamily: "BoldFont",
    color: AppColors.DarkTextColor,
    fontSize: 40,
  );
  static const TextStyle OnboardingSubTitleTextStyle = TextStyle(
    fontFamily: "RegularFont",
    color: AppColors.DarkTextColor,
    fontSize: 20,
  );
  static const TextStyle PageButtonTextStyle = TextStyle(
    fontFamily: "MediumFont",
    color: AppColors.ButtonTextColor,
    fontSize: 24,
  );
  static const TextStyle LinkButtonTextStyle = TextStyle(
    fontFamily: "MediumFont",
    color: AppColors.LinkButtonTextColor,
    fontSize: 18,
  );
  static const TextStyle ClockTextStyle = TextStyle(
    fontFamily: "ClockFont",
    color: AppColors.LightTextColor,
    fontSize: 36,
  );
  static const TextStyle YellowClock44TextStyle = TextStyle(
    fontFamily: "ClockFont",
    color: AppColors.YellowTextColor,
    fontSize: 44,
  );

  // Button Styles
  static ButtonStyle PageButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.ButtonBackgroundColor,
    side: BorderSide.none,
    shape: const StadiumBorder(),
    elevation: 0,
  );
  static ButtonStyle DisabledPageButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.ButtonBackgroundColor.withValues(alpha: 0.5),
    side: BorderSide.none,
    shape: const StadiumBorder(),
    elevation: 0,
  );
  static ButtonStyle LinkButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent,
    side: BorderSide.none,
    elevation: 0,
  );
}

import 'package:flutter/material.dart';
import 'package:muslim_life_mosque_edition/Shared/app_colors.dart';

class AppStyles {
  // Text Styles

  //Yellow Extra Bold Text Styles
  static const TextStyle YellowExtraBold40TextStyle = TextStyle(
    fontFamily: "ExtraBoldFont",
    color: AppColors.YellowTextColor,
    fontSize: 40,
  );

  //Yellow Medium Styles
  static const TextStyle YellowBold16TextStyle = TextStyle(
    fontFamily: "BoldFont",
    color: AppColors.YellowTextColor,
    fontSize: 16,
  );

  //Yellow Regular Styles
  static const TextStyle YellowRegular16TextStyle = TextStyle(
    fontFamily: "RegularFont",
    color: AppColors.YellowTextColor,
    fontSize: 16,
  );

  //Regular Light Text Styles
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
  static const TextStyle MediumLight18TextStyle = TextStyle(
    fontFamily: "MediumFont",
    color: AppColors.LightTextColor,
    fontSize: 18,
  );

  //Medium Dark Text Styles
  static const TextStyle MediumDark24TextStyle = TextStyle(
    fontFamily: "MediumFont",
    color: AppColors.DarkTextColor,
    fontSize: 24,
  );

  //Light Light Text Styles
  // static const TextStyle LightLight12TextStyle = TextStyle(
  //   fontFamily: "LightFont",
  //   color: AppColors.LightTextColor,
  //   fontSize: 12,
  // );

  // //Bold Light Text Styles
  // static const TextStyle BoldLight40TextStyle = TextStyle(
  //   fontFamily: "BoldFont",
  //   color: AppColors.LightTextColor,
  //   fontSize: 40,
  // );

  //Bold Dark Text Styles
  // static const TextStyle BoldDark22TextStyle = TextStyle(
  //   fontFamily: "BoldFont",
  //   color: AppColors.DarkTextColor,
  //   fontSize: 22,
  // );

  //Bold Narrow Light Text Styles
  // static const TextStyle BoldNarrowLight13TextStyle = TextStyle(
  //   fontFamily: "BoldNarrowFont",
  //   color: AppColors.LightTextColor,
  //   fontSize: 13,
  // );

  //Arabic Fonts
  // static const TextStyle ArabicHeaderBoldDark18TextStyle = TextStyle(
  //   fontFamily: "ArabicHeaderFont",
  //   color: AppColors.DarkTextColor,
  //   fontSize: 18,
  //   fontWeight: FontWeight.w600,
  // );
  // static const TextStyle ArabicHeaderExtraBoldDark24TextStyle = TextStyle(
  //   fontFamily: "ArabicHeaderFont",
  //   color: AppColors.DarkTextColor,
  //   fontSize: 24,
  //   fontWeight: FontWeight.w800,
  // );
  // static const TextStyle QuranDark34TextStyle = TextStyle(
  //   fontFamily: "QuranFont",
  //   color: AppColors.DarkTextColor,
  //   fontSize: 34,
  //   fontWeight: FontWeight.w400,
  // );

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
    fontSize: 40,
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

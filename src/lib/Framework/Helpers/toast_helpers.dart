import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:muslim_life_mosque_edition/Shared/app_colors.dart';
import 'package:muslim_life_mosque_edition/Shared/app_styles.dart';

class ToastHelpers {
  static void showVeryLongToast(BuildContext context, String message, {bool isError = false}) {
    DelightToastBar(
      autoDismiss: true,
      snackbarDuration: 6000.milliseconds,
      position: DelightSnackbarPosition.top,
      builder: (context) => ToastCard(
        color: isError ? AppColors.ErrorColor : AppColors.ButtonBackgroundColor,
        leading: Icon(isError ? Icons.error_outline : Icons.check_outlined, size: 22, color: AppColors.LightTextColor),
        title: Text(message, style: AppStyles.ToastTextStyle),
      ),
    ).show(context);
  }

  static void showLongToast(BuildContext context, String message, {bool isError = false}) {
    DelightToastBar(
      autoDismiss: true,
      snackbarDuration: 2000.milliseconds,
      builder: (context) => ToastCard(
        color: isError ? AppColors.ErrorColor : AppColors.ButtonBackgroundColor,
        leading: Icon(isError ? Icons.error_outline : Icons.check_outlined, size: 22, color: AppColors.LightTextColor),
        title: Text(message, style: AppStyles.ToastTextStyle),
      ),
    ).show(context);
  }

  static void showMediumToast(BuildContext context, String message, {bool isError = false}) {
    DelightToastBar(
      autoDismiss: true,
      snackbarDuration: 1500.milliseconds,
      builder: (context) => ToastCard(
        color: isError ? AppColors.ErrorColor : AppColors.ButtonBackgroundColor,
        leading: Icon(isError ? Icons.error_outline : Icons.check_outlined, size: 22, color: AppColors.LightTextColor),
        title: Text(message, style: AppStyles.ToastTextStyle),
      ),
    ).show(context);
  }

  static void showShortToast(BuildContext context, String message, {bool isError = false}) {
    DelightToastBar(
      autoDismiss: true,
      snackbarDuration: 1000.milliseconds,
      animationDuration: 600.milliseconds,
      builder: (context) => ToastCard(
        color: isError ? AppColors.ErrorColor : AppColors.ButtonBackgroundColor,
        leading: Icon(isError ? Icons.error_outline : Icons.check_outlined, size: 22, color: AppColors.LightTextColor),
        title: Text(message, style: AppStyles.ToastTextStyle),
      ),
    ).show(context);
  }
}

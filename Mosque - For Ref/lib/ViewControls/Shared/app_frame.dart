import 'package:flutter/material.dart';
import 'package:muslimlife/Shared/app_colors.dart';
import 'package:muslimlife/ViewControls/Shared/error_indicator.dart';
import 'package:muslimlife/ViewControls/Shared/loading_indicator.dart';

class AppFrame extends StatelessWidget {
  final Widget child;
  final bool isErrorState;
  final String errorMessage;
  final bool isBusy;
  final String loadingText;
  final bool dataLoaded;

  const AppFrame({
    super.key,
    required this.child,
    required this.isErrorState,
    required this.errorMessage,
    required this.isBusy,
    required this.loadingText,
    required this.dataLoaded,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.PageBackgroundColor,
    body: Container(
      width: double.infinity,
      height: double.infinity,
      color: AppColors.PageBackgroundColor,
      child: _mainContentArea(child),
    ),
  );

  Widget _mainContentArea(Widget child) {
    //Show Error Indicator
    if (isErrorState) {
      return Center(child: ErrorIndicator(errorText: errorMessage));
    }

    //Show Loading Indicator
    if (isBusy) {
      return Center(child: LoadingIndicator(loadingText: loadingText, indicatorColor: AppColors.DarkIndicatorColor));
    }

    //Show UI
    if (dataLoaded) {
      return child;
    }

    //Show Empty Page
    return Container();
  }
}

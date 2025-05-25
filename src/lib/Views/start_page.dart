import 'package:flutter/material.dart';
import 'package:muslim_life_mosque_edition/Shared/app_colors.dart';
import 'package:muslim_life_mosque_edition/Shared/app_styles.dart';
import 'package:muslim_life_mosque_edition/ViewControls/shared/error_indicator.dart';
import 'package:muslim_life_mosque_edition/ViewControls/shared/loading_indicator.dart';
import 'package:muslim_life_mosque_edition/ViewModels/start_page_view_model.dart';
import 'package:stacked/stacked.dart';

class StartPage extends StackedView<StartPageViewModel> {
  late StartPageViewModel pageViewModel;

  StartPage({super.key});

  @override
  StartPageViewModel viewModelBuilder(BuildContext context) {
    pageViewModel = StartPageViewModel();
    pageViewModel.screenContext = context;
    return pageViewModel;
  }

  @override
  void onViewModelReady(StartPageViewModel viewModel) async {
    await viewModel.loadData();
  }

  @override
  Widget builder(BuildContext context, StartPageViewModel viewModel, Widget? child) =>
      Scaffold(backgroundColor: AppColors.StartPageBackgroundColor, body: _mainContentArea(context, viewModel));

  Widget _mainContentArea(BuildContext context, StartPageViewModel viewModel) {
    //Show Error Indicator
    if (viewModel.IsErrorState) {
      return ErrorIndicator(errorText: viewModel.ErrorMessage);
    }

    //Show Loading Indicator
    if (viewModel.IsBusy) {
      return LoadingIndicator(indicatorColor: AppColors.LightIndicatorColor);
    }

    //Return empty container if data has not yet been loaded
    if (!viewModel.DataLoaded) {
      return Container();
    }

    //Return Main Content
    return Stack(
      children: [
        Positioned(
          top: 32,
          left: 32,
          child: Text(viewModel.mosque.mosqueName!, style: AppStyles.YellowBold32TextStyle),
        ),
      ],
    );
  }
}

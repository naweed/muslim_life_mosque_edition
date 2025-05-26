import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:muslim_life_mosque_edition/Shared/app_colors.dart';
import 'package:muslim_life_mosque_edition/Shared/app_styles.dart';
import 'package:muslim_life_mosque_edition/ViewControls/shared/error_indicator.dart';
import 'package:muslim_life_mosque_edition/ViewControls/shared/loading_indicator.dart';
import 'package:muslim_life_mosque_edition/ViewModels/start_page_view_model.dart';
import 'package:stacked/stacked.dart';

class StartPage extends StackedView<StartPageViewModel> {
  late StartPageViewModel pageViewModel;

  double itemHorizontalPaddingUnit = 24.0;
  double itemVerticalPaddingUnit = 16.0;

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
    return LayoutGrid(
      columnSizes: [itemHorizontalPaddingUnit.px, 1.fr, itemHorizontalPaddingUnit.px],
      rowSizes: [itemVerticalPaddingUnit.px, auto, 1.fr, auto, itemVerticalPaddingUnit.px],
      children: [
        //Top Header (Mosque Name and Time)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Mosque Name
            Text(viewModel.mosque.mosqueName!, style: AppStyles.YellowExtraBold40TextStyle),
            //Time
            Text(viewModel.CurrentTime, style: AppStyles.ClockTextStyle),
          ],
        ).withGridPlacement(columnStart: 1, rowStart: 1),

        //Bottom Ayah and App Info
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "\"Indeed, prayer has been decreed upon the believers at specified times.\"",
                  style: AppStyles.YellowBold16TextStyle,
                ),
                Text(" - Sura An-Nisa (4:103)", style: AppStyles.YellowRegular16TextStyle),
              ],
            ),

            Text(
              "Masjid Pulse TV v1.0  |  Prayer times for ${viewModel.mosque.addressCity}, ${viewModel.mosque.addressCountryName}",
              style: AppStyles.RegularLight14TextStyle,
            ),
          ],
        ).withGridPlacement(columnStart: 1, rowStart: 3),
      ],
    );
  }
}

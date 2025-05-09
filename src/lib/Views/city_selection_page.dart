import 'package:flutter/material.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/device_extensions.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/navigation_extentions.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/padding_extensions.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/sized_box_extensions.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/widget_extensions.dart';
import 'package:muslim_life_mosque_edition/Shared/app_assets.dart';
import 'package:muslim_life_mosque_edition/Shared/app_colors.dart';
import 'package:muslim_life_mosque_edition/Shared/app_styles.dart';
import 'package:muslim_life_mosque_edition/ViewControls/city_selection_page/city_display_cell.dart';
import 'package:muslim_life_mosque_edition/ViewControls/shared/error_indicator.dart';
import 'package:muslim_life_mosque_edition/ViewControls/shared/loading_indicator.dart';
import 'package:muslim_life_mosque_edition/ViewControls/shared/page_button.dart';
import 'package:muslim_life_mosque_edition/ViewModels/city_selection_page_view_model.dart';
import 'package:muslim_life_mosque_edition/Views/start_page.dart';
import 'package:stacked/stacked.dart';
import 'package:super_sliver_list/super_sliver_list.dart';

class CitySelectionPage extends StackedView<CitySelectionPageViewModel> {
  final String selectedCountry;
  late CitySelectionPageViewModel pageViewModel;

  CitySelectionPage({super.key, required this.selectedCountry});

  @override
  CitySelectionPageViewModel viewModelBuilder(BuildContext context) {
    pageViewModel = CitySelectionPageViewModel();
    return pageViewModel;
  }

  @override
  void onViewModelReady(CitySelectionPageViewModel viewModel) async {
    await viewModel.loadData(selectedCountry);
  }

  @override
  Widget builder(BuildContext context, CitySelectionPageViewModel viewModel, Widget? child) =>
      Scaffold(backgroundColor: AppColors.AppPrimaryColor, body: SafeArea(child: _buildUI(context, viewModel)));

  Widget _buildUI(BuildContext context, CitySelectionPageViewModel viewModel) {
    //Show Error Indicator
    if (viewModel.IsErrorState) {
      return ErrorIndicator(errorText: viewModel.ErrorMessage);
    }

    //Show Loading Indicator
    if (viewModel.IsBusy) {
      return LoadingIndicator(loadingText: viewModel.LoadingText, indicatorColor: AppColors.LightIndicatorColor);
    }

    //Show UI
    if (viewModel.DataLoaded) {
      return Container(
        padding: (48, 48, 48, 48).withLTRBPadding(),
        width: double.infinity,
        height: double.infinity,
        color: AppColors.AppPrimaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(AppAssets.CityImage, width: context.width * 0.3, opacity: const AlwaysStoppedAnimation(.8)),
            48.toHorizontalSpacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Select your City!", style: AppStyles.MediumLight24TextStyle),
                8.toVerticalSpacer(),
                Container(
                  padding: 8.withAllPadding(),
                  height: 57,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.TextboxBackgroundColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    onChanged: (text) => viewModel.OnCitySearchTextChanged(),
                    controller: viewModel.CitySearchController,
                    style: AppStyles.RegularDark16TextStyle,
                    decoration: InputDecoration(
                      filled: true,
                      contentPadding: (12, 0, 12, 6).withLTRBPadding(),
                      hintStyle: AppStyles.RegularDark16TextStyle.copyWith(
                        color: AppColors.DarkGrayColor.withValues(alpha: 0.7),
                      ),
                      hintText: "Search for your nearest city...",
                      border: InputBorder.none,
                      fillColor: Colors.transparent,
                    ),
                  ),
                ),
                12.toVerticalSpacer(),
                SuperListView.separated(
                  itemCount: viewModel.Cities.length,
                  itemBuilder: (context, index) {
                    final city = viewModel.Cities[index];

                    return CityDisplayCell(
                      city: city,
                      isSelected: city.name! == viewModel.SelectedCity,
                      onTapped: () => viewModel.setSelectedCity(city),
                    );
                  },
                  separatorBuilder: (context, index) => 12.toVerticalSpacer(),
                ).expandWidget(),
                12.toVerticalSpacer(),
                PageButton(
                  isEnabled: viewModel.SelectedCity != "",
                  text: "Next",
                  onPressed: () async {
                    //Save My Location
                    await viewModel.saveMyLocation();

                    //Save Prayer and Asr Methods
                    await viewModel.saveCalculationMethods();

                    //Save Location Permission Status
                    await viewModel.saveLocationPermissionStatus();

                    //Save Manual Adjustments
                    await viewModel.saveManualAdjustments();

                    // Navigate to Start Page
                    context.pushReplacement(StartPage());
                  },
                ),
              ],
            ).expandWidget(),
          ],
        ),
      );
    }

    //Return Empty Page
    return Container();
  }
}

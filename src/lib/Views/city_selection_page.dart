import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/navigation_extentions.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/padding_extensions.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/sized_box_extensions.dart';
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
        padding: (44, 0, 44, 0).withLTRBPadding(),
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            CustomScrollView(
              scrollDirection: Axis.vertical,
              slivers: [
                //Page Header
                SliverAppBar(
                  //Back Icon
                  leadingWidth: 56 - 16,
                  leading: GestureDetector(
                    onTap: () => context.popPage(),
                    child: Container(padding: 6.withAllPadding(), child: SvgPicture.asset(AppAssets.BackIcon)),
                  ),
                  backgroundColor: AppColors.AppPrimaryColor,
                  surfaceTintColor: Colors.transparent,
                  elevation: 0,
                  pinned: true,
                  centerTitle: true,
                  bottom: PreferredSize(
                    // Add this code
                    preferredSize: Size.fromHeight(76.0), // Add this code
                    child: Container(
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
                          hintText: "Search for your city...",
                          border: InputBorder.none,
                          fillColor: Colors.transparent,
                        ),
                      ),
                    ).withLTRBPadding(0, 0, 0, 12),
                  ),
                  title: const Text("Select your City!", style: AppStyles.MediumLight24TextStyle),
                ),

                //Countries List
                SuperSliverList.separated(
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
                ),
              ],
            ).withLTRBPadding(0, 0, 0, 96),

            // Next button
            Container(
              width: double.infinity,
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: (0, 0, 0, 28).withLTRBPadding(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
                ),
              ),
            ),
          ],
        ),
      );
    }

    //Return Empty Page
    return Container();
  }
}

import 'package:flutter/material.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/navigation_extentions.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/padding_extensions.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/sized_box_extensions.dart';
import 'package:muslim_life_mosque_edition/Shared/app_colors.dart';
import 'package:muslim_life_mosque_edition/Shared/app_styles.dart';
import 'package:muslim_life_mosque_edition/ViewControls/country_selection_page/country_display_cell.dart';
import 'package:muslim_life_mosque_edition/ViewControls/shared/page_button.dart';
import 'package:muslim_life_mosque_edition/ViewModels/country_selection_page_view_model.dart';
import 'package:muslim_life_mosque_edition/Views/city_selection_page.dart';
import 'package:stacked/stacked.dart';
import 'package:super_sliver_list/super_sliver_list.dart';

class CountrySelectionPage extends StackedView<CountrySelectionPageViewModel> {
  late CountrySelectionPageViewModel pageViewModel;

  CountrySelectionPage({super.key});

  @override
  CountrySelectionPageViewModel viewModelBuilder(BuildContext context) {
    pageViewModel = CountrySelectionPageViewModel();
    return pageViewModel;
  }

  @override
  void onViewModelReady(CountrySelectionPageViewModel viewModel) async {
    await viewModel.loadData();
  }

  @override
  Widget builder(BuildContext context, CountrySelectionPageViewModel viewModel, Widget? child) => Scaffold(
    backgroundColor: AppColors.AppPrimaryColor,
    body: SafeArea(
      child: Container(
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
                        onChanged: (text) => viewModel.OnCountrySearchTextChanged(),
                        controller: viewModel.CountrySearchController,
                        style: AppStyles.RegularDark16TextStyle,
                        decoration: InputDecoration(
                          filled: true,
                          contentPadding: (12, 0, 12, 6).withLTRBPadding(),
                          hintStyle: AppStyles.RegularDark16TextStyle.copyWith(
                            color: AppColors.DarkGrayColor.withValues(alpha: 0.7),
                          ),
                          hintText: "Search for your country...",
                          border: InputBorder.none,
                          fillColor: Colors.transparent,
                        ),
                      ),
                    ).withLTRBPadding(0, 0, 0, 12),
                  ),
                  title: const Text("Select your Country!", style: AppStyles.MediumLight24TextStyle),
                ),

                //Countries List
                SuperSliverList.separated(
                  itemCount: viewModel.Countries.length,
                  itemBuilder: (context, index) {
                    final country = viewModel.Countries[index];

                    return CountryDisplayCell(
                      country: country,
                      isSelected: country.id! == viewModel.SelectedCountry,
                      onTapped: () => viewModel.setSelectedCountry(country.id!),
                    );
                  },
                  separatorBuilder: (context, index) => 12.toVerticalSpacer(),
                ),
              ],
            ).withLTRBPadding(0, 0, 0, 96),

            // Cities button
            Container(
              width: double.infinity,
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: (0, 0, 0, 28).withLTRBPadding(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PageButton(
                      isEnabled: viewModel.SelectedCountry != "",
                      text: "Next",
                      onPressed: () => context.push(CitySelectionPage(selectedCountry: viewModel.SelectedCountry)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

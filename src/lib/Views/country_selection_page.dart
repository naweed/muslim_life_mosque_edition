import 'package:flutter/material.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/device_extensions.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/navigation_extentions.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/padding_extensions.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/sized_box_extensions.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/widget_extensions.dart';
import 'package:muslim_life_mosque_edition/Shared/app_assets.dart';
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
    body: Container(
      padding: (48, 48, 48, 48).withLTRBPadding(),
      width: double.infinity,
      height: double.infinity,
      color: AppColors.AppPrimaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(AppAssets.CountryImage, width: context.width * 0.3, opacity: const AlwaysStoppedAnimation(.8)),
          48.toHorizontalSpacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Select your Country!", style: AppStyles.MediumLight24TextStyle),
              12.toVerticalSpacer(),
              SuperListView.separated(
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
              ).expandWidget(),
              12.toVerticalSpacer(),
              PageButton(
                isEnabled: viewModel.SelectedCountry != "",
                text: "Next",
                onPressed: () => context.push(CitySelectionPage(selectedCountry: viewModel.SelectedCountry)),
              ),
            ],
          ).expandWidget(),
        ],
      ),
    ),
  );
}

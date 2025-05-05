import 'package:flutter/material.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/device_extensions.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/navigation_extentions.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/padding_extensions.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/sized_box_extensions.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/widget_extensions.dart';
import 'package:muslim_life_mosque_edition/Shared/app_assets.dart';
import 'package:muslim_life_mosque_edition/Shared/app_colors.dart';
import 'package:muslim_life_mosque_edition/Shared/app_styles.dart';
import 'package:muslim_life_mosque_edition/ViewControls/shared/link_button.dart';
import 'package:muslim_life_mosque_edition/ViewControls/shared/page_button.dart';
import 'package:muslim_life_mosque_edition/ViewModels/location_permissions_page_view_model.dart';
import 'package:muslim_life_mosque_edition/Views/country_selection_page.dart';
import 'package:stacked/stacked.dart';

class LocationPermissionsPage extends StackedView<LocationPermissionPageViewModel> {
  late LocationPermissionPageViewModel pageViewModel;

  LocationPermissionsPage({super.key});

  @override
  LocationPermissionPageViewModel viewModelBuilder(BuildContext context) {
    pageViewModel = LocationPermissionPageViewModel();
    return pageViewModel;
  }

  @override
  void onViewModelReady(LocationPermissionPageViewModel viewModel) async {}

  @override
  Widget builder(BuildContext context, LocationPermissionPageViewModel viewModel, Widget? child) => Scaffold(
    body: Container(
      padding: (48, 48, 48, 48).withLTRBPadding(),
      width: double.infinity,
      height: double.infinity,
      color: AppColors.AppPrimaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(AppAssets.OnboardingLocationPermission, width: context.width * 0.3),
          48.toHorizontalSpacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(viewModel.Title, style: AppStyles.OnboardingTitleTextStyle),
              8.toVerticalSpacer(),
              Text(
                viewModel.Description,
                style: AppStyles.OnboardingSubTitleTextStyle.copyWith(height: 1.25),
                textAlign: TextAlign.center,
              ),
              64.toVerticalSpacer(),
              PageButton(
                text: viewModel.ButtonText,
                isEnabled: viewModel.isButtonEnabled,
                onPressed: () async => await viewModel.onLocateMePressed(context),
              ),
              2.toVerticalSpacer(),
              LinkButton(
                text: "Skip! I will choose my city",
                onPressed: () {
                  // Navigate to Contry Selection Page
                  context.pushReplacement(CountrySelectionPage());
                },
              ),
            ],
          ).expandWidget(),
        ],
      ),
    ),
  );
}

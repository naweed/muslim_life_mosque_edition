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
    body: Stack(
      children: [
        // Permission Icon
        Container(
          padding: (84, 0, 84, 36).withLTRBPadding(),
          width: double.infinity,
          height: double.infinity,
          color: AppColors.AppPrimaryColor,
          child: SizedBox(
            height: context.height * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(AppAssets.OnboardingLocationPermission, height: context.height * 0.4).expandWidget(flex: 2),
                Column(
                  children: [
                    Text(viewModel.Title, style: AppStyles.OnboardingTitleTextStyle),
                    4.toVerticalSpacer(),
                    Text(
                      viewModel.Description,
                      style: AppStyles.OnboardingSubTitleTextStyle.copyWith(height: 1.25),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ).expandWidget(flex: 2),
              ],
            ),
          ),
        ),

        // Permission buttons
        Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: (84, 0, 84, 28).withLTRBPadding(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PageButton(
                  text: viewModel.ButtonText,
                  isEnabled: viewModel.isButtonEnabled,
                  onPressed: () async => await viewModel.onLocateMePressed(context),
                ),
                4.toVerticalSpacer(),
                LinkButton(
                  text: "Skip! I will choose my city",
                  onPressed: () {
                    // Navigate to Contry Selection Page
                    context.pushReplacement(CountrySelectionPage());
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

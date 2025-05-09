import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:muslim_life_mosque_edition/Actions/enter_button_action.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/device_extensions.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/navigation_extentions.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/padding_extensions.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/sized_box_extensions.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/widget_extensions.dart';
import 'package:muslim_life_mosque_edition/Intents/enter_button_intent.dart';
import 'package:muslim_life_mosque_edition/Shared/app_assets.dart';
import 'package:muslim_life_mosque_edition/Shared/app_colors.dart';
import 'package:muslim_life_mosque_edition/Shared/app_styles.dart';
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
    pageViewModel.screenContext = context;
    return pageViewModel;
  }

  @override
  void onViewModelReady(LocationPermissionPageViewModel viewModel) async {
    viewModel.requestFocus();
  }

  @override
  Widget builder(BuildContext context, LocationPermissionPageViewModel viewModel, Widget? child) => Scaffold(
    body: Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{LogicalKeySet(LogicalKeyboardKey.select): EnterButtonIntent()},
      child: Container(
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
                Container(
                  padding: 8.withAllPadding(),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.LightIndicatorColor.withValues(alpha: 0.8), width: 1.5),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: Actions(
                    actions: <Type, Action<Intent>>{
                      EnterButtonIntent: EnterButtonAction(
                        () async => await context.pushReplacement(CountrySelectionPage()),
                      ),
                    },
                    child: Focus(
                      focusNode: viewModel.continueButtonFocus,
                      child: PageButton(
                        text: viewModel.ButtonText,
                        isEnabled: viewModel.isButtonEnabled,
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
              ],
            ).expandWidget(),
          ],
        ),
      ),
    ),
  );
}

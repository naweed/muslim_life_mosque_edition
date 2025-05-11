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
import 'package:muslim_life_mosque_edition/ViewControls/city_selection_page/city_display_cell.dart';
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
    pageViewModel.screenContext = context;
    return pageViewModel;
  }

  @override
  void onViewModelReady(CitySelectionPageViewModel viewModel) async {
    await viewModel.loadData(selectedCountry);
    await Future.delayed(const Duration(milliseconds: 100));
    viewModel.requestFocus();
  }

  @override
  Widget builder(BuildContext context, CitySelectionPageViewModel viewModel, Widget? child) => Scaffold(
    body: Focus(
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
            viewModel.moveFocusUp();
            return KeyEventResult.handled;
          } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
            viewModel.moveFocusDown();
            return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      },
      child: Shortcuts(
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
              Image.asset(AppAssets.CityImage, width: context.width * 0.3, opacity: const AlwaysStoppedAnimation(.8)),
              48.toHorizontalSpacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Select your Nearest City!", style: AppStyles.MediumDark24TextStyle),
                  12.toVerticalSpacer(),
                  SuperListView.separated(
                    controller: viewModel.scrollController,
                    itemCount: viewModel.Cities.length,
                    itemBuilder: (context, index) {
                      final city = viewModel.Cities[index];

                      return CityDisplayCell(
                        city: city,
                        isSelected: city.name! == viewModel.SelectedCity,
                        onTapped: () {
                          viewModel.setSelectedCity(city);
                          viewModel.focusNextButton();
                        },
                        focusNode: viewModel.cityFocusNodes[index],
                      );
                    },
                    separatorBuilder: (context, index) => 12.toVerticalSpacer(),
                    cacheExtent: 1000,
                  ).expandWidget(),
                  12.toVerticalSpacer(),
                  Container(
                    padding: 8.withAllPadding(),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            viewModel.nextButtonFocus.hasFocus
                                ? AppColors.ButtonBackgroundColor.withValues(alpha: 0.8)
                                : Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: Actions(
                      actions: <Type, Action<Intent>>{
                        EnterButtonIntent: EnterButtonAction(() async {
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
                        }),
                      },
                      child: Focus(
                        focusNode: viewModel.nextButtonFocus,
                        onKeyEvent: (node, event) {
                          if (event is KeyDownEvent) {
                            if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
                              viewModel.moveFocusUp();
                              return KeyEventResult.handled;
                            }
                          }
                          return KeyEventResult.ignored;
                        },
                        child: PageButton(isEnabled: viewModel.SelectedCity != "", text: "Next", onPressed: () {}),
                      ),
                    ),
                  ),
                ],
              ).expandWidget(),
            ],
          ),
        ),
      ),
    ),
  );
}

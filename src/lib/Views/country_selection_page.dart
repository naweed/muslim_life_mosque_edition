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
    pageViewModel.screenContext = context;
    return pageViewModel;
  }

  @override
  void onViewModelReady(CountrySelectionPageViewModel viewModel) async {
    await viewModel.loadData();
    await Future.delayed(const Duration(milliseconds: 100));
    viewModel.requestFocus();
  }

  @override
  Widget builder(BuildContext context, CountrySelectionPageViewModel viewModel, Widget? child) => Scaffold(
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
              Image.asset(
                AppAssets.CountryImage,
                width: context.width * 0.3,
                opacity: const AlwaysStoppedAnimation(.8),
              ),
              48.toHorizontalSpacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Select your Country!", style: AppStyles.MediumLight24TextStyle),
                  12.toVerticalSpacer(),
                  SuperListView.separated(
                    controller: viewModel.scrollController,
                    itemCount: viewModel.Countries.length,
                    itemBuilder: (context, index) {
                      final country = viewModel.Countries[index];

                      return CountryDisplayCell(
                        country: country,
                        isSelected: country.id! == viewModel.SelectedCountry,
                        onTapped: () {
                          viewModel.setSelectedCountry(country.id!);
                          viewModel.focusNextButton();
                        },
                        focusNode: viewModel.countryFocusNodes[index],
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
                                ? AppColors.LightIndicatorColor.withValues(alpha: 0.8)
                                : Colors.transparent,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: Actions(
                      actions: <Type, Action<Intent>>{
                        EnterButtonIntent: EnterButtonAction(
                          () => context.push(CitySelectionPage(selectedCountry: viewModel.SelectedCountry)),
                        ),
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
                        child: PageButton(isEnabled: viewModel.SelectedCountry != "", text: "Next", onPressed: () {}),
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

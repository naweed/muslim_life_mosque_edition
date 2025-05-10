import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:muslim_life_mosque_edition/Actions/enter_button_action.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/navigation_extentions.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/padding_extensions.dart';
import 'package:muslim_life_mosque_edition/Intents/enter_button_intent.dart';
import 'package:muslim_life_mosque_edition/Shared/app_colors.dart';
import 'package:muslim_life_mosque_edition/Shared/app_constants.dart';
import 'package:muslim_life_mosque_edition/ViewControls/onboarding_page/onboarding_content_widget.dart';
import 'package:muslim_life_mosque_edition/ViewModels/onboarding_page_view_model.dart';
import 'package:muslim_life_mosque_edition/Views/location_permissions_page.dart';
import 'package:stacked/stacked.dart';

class OnboardingPage extends StackedView<OnboardingPageViewModel> {
  late OnboardingPageViewModel pageViewModel;

  OnboardingPage({super.key});

  @override
  OnboardingPageViewModel viewModelBuilder(BuildContext context) {
    pageViewModel = OnboardingPageViewModel();
    pageViewModel.screenContext = context;
    return pageViewModel;
  }

  @override
  void onViewModelReady(OnboardingPageViewModel viewModel) async {
    viewModel.requestFocus();
    unawaited(viewModel.loadDataForCaching());
  }

  @override
  Widget builder(BuildContext context, OnboardingPageViewModel viewModel, Widget? child) => Scaffold(
    backgroundColor: AppColors.PageBackgroundColor,
    body: Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{LogicalKeySet(LogicalKeyboardKey.select): EnterButtonIntent()},
      child: Stack(
        children: [
          // Liquid Swipe Control
          LiquidSwipe(
            liquidController: viewModel.liquidController,
            enableLoop: false,
            disableUserGesture: true,
            pages: viewModel.OnboardingScreens.map((screen) => OnboardingContentWidget(model: screen)).toList(),
          ),

          // Bottom Bar for indicator and Next buttons
          Container(
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: 36.withAllPadding(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Indicators
                  Row(
                    children: List.generate(
                      viewModel.OnboardingScreens.length,
                      (index) => _buildDot(index, context, viewModel),
                    ),
                  ),
                  // Next Onboarding screen button
                  Actions(
                    actions: <Type, Action<Intent>>{
                      EnterButtonIntent: EnterButtonAction(() async {
                        if (viewModel.currentPage == viewModel.OnboardingScreens.length - 1) {
                          //Save Onboarding Status
                          await viewModel.saveOnboardingStatus();

                          // Navigate to Permissions screen
                          await context.pushReplacement(LocationPermissionsPage());
                          return;
                        }

                        // Go to next onboarding screen
                        viewModel.currentPage++;
                        viewModel.liquidController.animateToPage(page: viewModel.currentPage, duration: 0);
                      }),
                    },

                    child: Focus(
                      focusNode: viewModel.nextButtonFocus,
                      canRequestFocus: true,
                      child: Container(
                        padding: 8.withAllPadding(),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.LightIndicatorColor.withValues(alpha: 0.8), width: 1.5),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),

                        child: CupertinoButton(
                          padding: 0.withAllPadding(),
                          onPressed: () async {},
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                height: 64,
                                width: 64,
                                child: CircularProgressIndicator(
                                  backgroundColor: AppColors.LightIndicatorColor.withValues(alpha: 0.2),
                                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.DarkGreenColor),
                                  value: (viewModel.currentPage + 1) / viewModel.OnboardingScreens.length,
                                ),
                              ),
                              const CircleAvatar(
                                backgroundColor: AppColors.DarkGreenColor,
                                child: Icon(Icons.arrow_forward_ios_outlined, color: AppColors.LightIndicatorColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );

  AnimatedContainer _buildDot(int index, BuildContext context, OnboardingPageViewModel viewModel) => AnimatedContainer(
    duration: AppConstants.SmallDuration.milliseconds,
    curve: Curves.easeInOut,
    height: 12,
    width: viewModel.currentPage == index ? 32 : 12,
    margin: 12.withRightPadding(),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: viewModel.currentPage == index ? AppColors.DarkGreenColor : AppColors.LightIndicatorColor,
    ),
  );
}

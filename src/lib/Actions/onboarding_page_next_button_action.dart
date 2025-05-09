import 'package:flutter/material.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/navigation_extentions.dart';
import 'package:muslim_life_mosque_edition/Intents/next_button_intent.dart';
import 'package:muslim_life_mosque_edition/ViewModels/onboarding_page_view_model.dart';
import 'package:muslim_life_mosque_edition/Views/location_permissions_page.dart';

class OnboardingPageNextButtonAction extends Action<NextButtonIntent> {
  OnboardingPageNextButtonAction(this.viewModel, this.context);

  final OnboardingPageViewModel viewModel;
  final BuildContext context;

  @override
  Future<int> invoke(covariant NextButtonIntent intent) async {
    if (viewModel.currentPage == viewModel.OnboardingScreens.length - 1) {
      //Save Onboarding Status
      await viewModel.saveOnboardingStatus();

      // Navigate to Permissions screen
      await context.pushReplacement(LocationPermissionsPage());
      return 0;
    }

    // Go to next onboarding screen
    viewModel.currentPage++;
    viewModel.liquidController.animateToPage(page: viewModel.currentPage, duration: 0);

    return 0;
  }
}

import 'package:flutter/material.dart';
import 'package:liquid_swipe/PageHelpers/LiquidController.dart';
import 'package:muslim_life_mosque_edition/Models/onboarding_content.dart';
import 'package:muslim_life_mosque_edition/Shared/app_constants.dart';
import 'package:muslim_life_mosque_edition/ViewModels/app_view_model.dart';

class OnboardingPageViewModel extends AppViewModel {
  late BuildContext screenContext;

  final LiquidController liquidController = LiquidController();
  final FocusNode nextButtonFocus = FocusNode();

  int _currentPage = 0;
  int get currentPage => _currentPage;
  set currentPage(int index) {
    _currentPage = index;
    notifyListeners();
  }

  List<OnboardingContent> get OnboardingScreens => OnboardingContent.onboardingScreens;

  OnboardingPageViewModel() : super() {
    this.Title = AppConstants.ApplicationName;
  }

  Future<void> loadDataForCaching() async {
    DataLoaded = true;
  }

  Future<void> saveOnboardingStatus() async {
    await appSettingsService.saveOnboardingCompleted();
  }

  void requestFocus() async {
    FocusScope.of(screenContext).requestFocus(nextButtonFocus);

    rebuildUi();
  }

  @override
  void dispose() {
    nextButtonFocus.dispose();
    super.dispose();
  }
}

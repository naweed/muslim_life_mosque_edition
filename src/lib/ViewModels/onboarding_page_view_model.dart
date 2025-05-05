import 'package:liquid_swipe/PageHelpers/LiquidController.dart';
import 'package:muslim_life_mosque_edition/Helpers/svg_helper.dart';
import 'package:muslim_life_mosque_edition/Models/onboarding_content.dart';
import 'package:muslim_life_mosque_edition/Shared/app_constants.dart';
import 'package:muslim_life_mosque_edition/ViewModels/app_view_model.dart';

class OnboardingPageViewModel extends AppViewModel {
  final LiquidController liquidController = LiquidController();

  int _currentPage = 0;
  int get currentPage => _currentPage;
  set currentPage(int index) {
    _currentPage = index;
    notifyListeners();
  }

  List<OnboardingContent> get OnboardingScreens => OnboardingContent.onboardingScreens;

  OnboardingPageViewModel() : super() {
    Title = AppConstants.ApplicationName;
  }

  Future<void> loadDataForCaching() async {
    try {
      //PreCache SVG Files
      await SvgHelper.preCacheSVGs();

      DataLoaded = true;
    } catch (ex) {}
  }

  Future<void> saveOnboardingStatus() async {
    await appSettingsService.saveOnboardingCompleted();
  }
}

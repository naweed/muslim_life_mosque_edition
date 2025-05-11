import 'package:muslim_life_mosque_edition/Shared/app_assets.dart';

class OnboardingContent {
  final String image;
  final String title;
  final String description;
  final String backgroundColor;

  OnboardingContent(this.image, this.title, this.description, this.backgroundColor);

  static List<OnboardingContent> onboardingScreens = [
    OnboardingContent(
      AppAssets.OnboardingScreen1,
      "Prayer Timings",
      "Get accurate, location-based prayer times, wherever you are. Customise calculation models to suit your needs.",
      "#ECE2C2",
    ),
    OnboardingContent(
      AppAssets.OnboardingScreen4,
      "Data Privacy",
      "We do not collect any information or share your data with third parties, ensuring you peace of mind. We will not clutter your screen with ads, and the app will remain free forever.",
      "#ECE2C2",
    ),
  ];
}

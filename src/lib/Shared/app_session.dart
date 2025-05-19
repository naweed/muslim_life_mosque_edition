import 'package:muslim_life_mosque_edition/Services/app_settings_service.dart';

class AppSession {
  static bool OnboadingCompleted = false;
  static bool MosqueCodeSelectionCompleted = false;

  static String AppUniqueKey = "";
  static DateTime? AppStartDate;

  static Future<void> setAppParameters(AppSettingService appSettingsService) async {
    // appSettingsService.clearAllPreferences();

    OnboadingCompleted = await appSettingsService.getOnboardingCompleted();
    MosqueCodeSelectionCompleted = await appSettingsService.getMosqueCodeSelectionCompleted();

    AppUniqueKey = await appSettingsService.getAppUniqueKey();
    AppStartDate = DateTime.parse(await appSettingsService.getAppStartDate());
  }
}

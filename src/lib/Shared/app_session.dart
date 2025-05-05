import 'package:muslim_life_mosque_edition/Services/app_settings_service.dart';

class AppSession {
  static bool OnboadingCompleted = false;
  static bool LocationSelectionCompleted = false;

  static String AppUniqueKey = "";
  static DateTime? AppStartDate;

  static String? MyLocation;
  static double? MyLatitude;
  static double? MyLongitude;

  static String? PrayerCalculationMethod;
  static String? AsrCalculationMethod;

  static int? FajrAdjustment;
  static int? DhuhrAdjustment;
  static int? AsrAdjustment;
  static int? MaghribAdjustment;
  static int? IshaAdjustment;
  static int? SunriseAdjustment;

  static String? Temp_PrayerCalculationMethod;
  static String? Temp_AsrCalculationMethod;

  static Future<void> setAppParameters(AppSettingService appSettingsService) async {
    // appSettingsService.clearAllPreferences();

    OnboadingCompleted = await appSettingsService.getOnboardingCompleted();
    LocationSelectionCompleted = await appSettingsService.getLocationSelectionCompleted();

    AppUniqueKey = await appSettingsService.getAppUniqueKey();
    AppStartDate = DateTime.parse(await appSettingsService.getAppStartDate());

    MyLocation = await appSettingsService.getMyLocation();
    MyLatitude = await appSettingsService.getMyLatitude();
    MyLongitude = await appSettingsService.getMyLongitude();

    PrayerCalculationMethod = await appSettingsService.getMyPrayerCalcMethod();
    AsrCalculationMethod = await appSettingsService.getMyAsrCalcMethod();

    FajrAdjustment = await appSettingsService.getMyFajrAdjustment();
    DhuhrAdjustment = await appSettingsService.getMyDhuhrAdjustment();
    AsrAdjustment = await appSettingsService.getMyAsrAdjustment();
    MaghribAdjustment = await appSettingsService.getMyMaghribAdjustment();
    IshaAdjustment = await appSettingsService.getMyIshaAdjustment();
    SunriseAdjustment = await appSettingsService.getMySunriseAdjustment();
  }
}

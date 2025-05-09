import 'package:muslim_life_mosque_edition/Shared/app_session.dart';
import 'package:muslim_life_mosque_edition/ViewModels/app_view_model.dart';

class LocationPermissionPageViewModel extends AppViewModel {
  String Description =
      "We need to know your location in order to find accurate prayer times. We promise that we will not use your location for any other purpose.";

  String ButtonText = "Continue";

  bool isButtonEnabled = true;

  LocationPermissionPageViewModel() : super() {
    Title = "Location Access!";
  }

  Future<void> saveMyLocation(String myLocation) async {
    await appSettingsService.saveMyLocation(myLocation);

    AppSession.MyLocation = myLocation;
  }

  Future<void> saveManualAdjustments() async {
    await appSettingsService.saveMyFajrAdjustment(0);
    await appSettingsService.saveMyDhuhrAdjustment(0);
    await appSettingsService.saveMyAsrAdjustment(0);
    await appSettingsService.saveMyMaghribAdjustment(0);
    await appSettingsService.saveMyIshaAdjustment(0);
    await appSettingsService.saveMySunriseAdjustment(0);

    AppSession.FajrAdjustment = 0;
    AppSession.DhuhrAdjustment = 0;
    AppSession.AsrAdjustment = 0;
    AppSession.MaghribAdjustment = 0;
    AppSession.IshaAdjustment = 0;
    AppSession.SunriseAdjustment = 0;
  }

  Future<void> saveLocationPermissionStatus() async {
    await appSettingsService.saveLocationSelectionCompleted();
  }

  Future<void> saveLocationCoordinates(double userLat, double userLon) async {
    await appSettingsService.saveMyLatitude(userLat);
    await appSettingsService.saveMyLongitude(userLon);

    AppSession.MyLatitude = userLat;
    AppSession.MyLongitude = userLon;
  }

  Future<void> savePrayerMethods(String prayerCalcMethod, String asrCalcMethod) async {
    await appSettingsService.saveMyAsrCalcMethod(asrCalcMethod);
    await appSettingsService.saveMyPrayerCalcMethod(prayerCalcMethod);

    AppSession.PrayerCalculationMethod = prayerCalcMethod;
    AppSession.AsrCalculationMethod = asrCalcMethod;
  }
}

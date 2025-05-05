import 'package:flutter/material.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/navigation_extentions.dart';
import 'package:muslim_life_mosque_edition/Framework/Helpers/location_helpers.dart';
import 'package:muslim_life_mosque_edition/Shared/app_session.dart';
import 'package:muslim_life_mosque_edition/ViewModels/app_view_model.dart';
import 'package:muslim_life_mosque_edition/Views/country_selection_page.dart';
import 'package:muslim_life_mosque_edition/Views/start_page.dart';

class LocationPermissionPageViewModel extends AppViewModel {
  String Description =
      "We need to know your location in order to find accurate prayer times. We promise that we will not use this location for any other purpose.";

  String ButtonText = "Locate Me";

  bool isButtonEnabled = true;

  LocationPermissionPageViewModel() : super() {
    this.Title = "Location Access!";
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

  Future<void> onLocateMePressed(BuildContext context) async {
    ButtonText = "Locating you ...";
    isButtonEnabled = false;
    rebuildUi();

    // Get Location Permissions
    await LocationHelpers.requestLocationermissions();

    //Check Location Permissions
    if (await LocationHelpers.locationermissionsGranted()) {
      //Save Location Permission Status
      await saveLocationPermissionStatus();

      //Get User Location and Save Coordibates
      double userLat = 0.0;
      double userLon = 0.0;

      (userLat, userLon) = await LocationHelpers.getLocationCoordinates();

      await saveLocationCoordinates(userLat, userLon);

      //Save Manua Adjustments
      await saveManualAdjustments();

      //Get Save My Location
      try {
        var myCity = await appApiService.getUserCity(userLat, userLon);
        await saveMyLocation(myCity.name!);

        try {
          var allCountries = await appDataService.getAllCountries();
          var country = allCountries.where((cntry) => cntry.id == myCity.countryCode!).first;

          await savePrayerMethods(country.pCalc!, country.asrCalc!);
        } catch (ex) {
          await savePrayerMethods("Muslim World League", "Shafi");
        }
      } catch (ex) {
        await saveMyLocation("My Location");
        await savePrayerMethods("Muslim World League", "Shafi");
      }

      // Navigate to Start Page
      context.pushReplacement(StartPage());
    } else {
      // Navigate to Contry Selection Page
      context.pushReplacement(CountrySelectionPage());
    }
  }
}

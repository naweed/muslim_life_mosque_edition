import 'package:flutter/material.dart';
import 'package:muslim_life_mosque_edition/Models/city.dart';
import 'package:muslim_life_mosque_edition/Shared/app_constants.dart';
import 'package:muslim_life_mosque_edition/Shared/app_session.dart';
import 'package:muslim_life_mosque_edition/ViewModels/app_view_model.dart';

class CitySelectionPageViewModel extends AppViewModel {
  List<City> _allCities = [];
  List<City> Cities = [];
  String SelectedCity = "";
  double SelectedLatitude = 0.0;
  double SelectedLongitude = 0.0;

  late TextEditingController CitySearchController;

  CitySelectionPageViewModel() : super() {
    this.Title = "City Selection";
    CitySearchController = TextEditingController();
  }

  Future<void> loadData(String countryCode) async {
    LoadingText = "";
    setDataLodingIndicators(true);

    try {
      //Get Cities
      _allCities = await appDataService.getCities(countryCode);
      Cities = _getCities();

      DataLoaded = true;
    } catch (ex) {
      IsErrorState = true;
      ErrorMessage =
          "Something went wrong. If the problem persists, plz contact support at ${AppConstants.SupportEmailAddress}.";
    } finally {
      setDataLodingIndicators(false);
    }
  }

  Future<void> OnCitySearchTextChanged() async {
    Cities = _getCities();
    SelectedCity = "";
    rebuildUi();
  }

  List<City> _getCities() {
    if (CitySearchController.text.isEmpty) {
      return _allCities;
    }

    return <City>[
      ..._allCities.where((city) => city.name!.toLowerCase().contains(CitySearchController.text.toLowerCase())),
    ];
  }

  void setSelectedCity(City city) {
    if (city.name! == SelectedCity) {
      SelectedCity = "";
      SelectedLatitude = 0.0;
      SelectedLongitude = 0.0;
    } else {
      SelectedCity = city.name!;
      SelectedLatitude = city.lat!;
      SelectedLongitude = city.lon!;
    }

    rebuildUi();
  }

  Future<void> saveMyLocation() async {
    await appSettingsService.saveMyLocation(SelectedCity);
    await appSettingsService.saveMyLatitude(SelectedLatitude);
    await appSettingsService.saveMyLongitude(SelectedLongitude);

    AppSession.MyLocation = SelectedCity;
    AppSession.MyLatitude = SelectedLatitude;
    AppSession.MyLongitude = SelectedLongitude;
  }

  Future<void> saveCalculationMethods() async {
    await appSettingsService.saveMyAsrCalcMethod(AppSession.Temp_AsrCalculationMethod!);
    await appSettingsService.saveMyPrayerCalcMethod(AppSession.Temp_PrayerCalculationMethod!);

    AppSession.PrayerCalculationMethod = AppSession.Temp_PrayerCalculationMethod;
    AppSession.AsrCalculationMethod = AppSession.Temp_AsrCalculationMethod;
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
}

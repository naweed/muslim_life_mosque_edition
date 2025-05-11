import 'package:flutter/material.dart';
import 'package:muslim_life_mosque_edition/Models/city.dart';
import 'package:muslim_life_mosque_edition/Shared/app_session.dart';
import 'package:muslim_life_mosque_edition/ViewModels/app_view_model.dart';

class CitySelectionPageViewModel extends AppViewModel {
  late BuildContext screenContext;

  final FocusNode nextButtonFocus = FocusNode();
  final List<FocusNode> cityFocusNodes = [];

  final ScrollController scrollController = ScrollController();
  int _currentFocusIndex = 0;

  List<City> _allCities = [];
  List<City> Cities = [];
  String SelectedCity = "";
  double SelectedLatitude = 0.0;
  double SelectedLongitude = 0.0;
  late TextEditingController CountrySearchController;

  CitySelectionPageViewModel() : super() {
    this.Title = "City Selection";
  }

  void requestFocus() async {
    if (Cities.isNotEmpty) {
      _currentFocusIndex = 0;

      FocusScope.of(screenContext).requestFocus(cityFocusNodes[0]);
      _scrollToFocusedItem();

      rebuildUi();
    }
  }

  void updateFocusNodes() {
    // Clear existing focus nodes
    for (var node in cityFocusNodes) {
      node.dispose();
    }

    cityFocusNodes.clear();

    // Create new focus nodes for each country
    for (var _ in Cities) {
      final node = FocusNode();

      node.addListener(() {
        if (node.hasFocus) {
          _currentFocusIndex = cityFocusNodes.indexOf(node);
          rebuildUi();
        }
      });

      cityFocusNodes.add(node);
    }

    _currentFocusIndex = 0;
  }

  void focusNextButton() {
    FocusScope.of(screenContext).requestFocus(nextButtonFocus);

    rebuildUi();
  }

  void moveFocusUp() {
    if (_currentFocusIndex > 0) {
      _currentFocusIndex--;

      FocusScope.of(screenContext).requestFocus(cityFocusNodes[_currentFocusIndex]);
      _scrollToFocusedItem();

      rebuildUi();
    }
  }

  void moveFocusDown() {
    if (_currentFocusIndex < Cities.length - 1) {
      _currentFocusIndex++;

      FocusScope.of(screenContext).requestFocus(cityFocusNodes[_currentFocusIndex]);
      _scrollToFocusedItem();

      rebuildUi();
    }
  }

  bool isItemFocused(int index) {
    return _currentFocusIndex == index;
  }

  void _scrollToFocusedItem() {
    if (!scrollController.hasClients) return;

    final itemHeight = 87.0; // Height of each item including padding

    // Calculate the target position to center the focused item
    final targetPosition = _currentFocusIndex * itemHeight;
    final newPosition = targetPosition;

    // Ensure we don't scroll beyond the list boundaries
    final maxScroll = scrollController.position.maxScrollExtent;
    final boundedPosition = newPosition.clamp(0.0, maxScroll);

    // Use jumpTo for immediate response
    scrollController.jumpTo(boundedPosition);
  }

  Future<void> loadData(String countryCode) async {
    LoadingText = "";
    setDataLodingIndicators(true);

    try {
      //Get Cities
      _allCities = await appDataService.getCities(countryCode);
      Cities = _getCities();

      updateFocusNodes();

      DataLoaded = true;
    } catch (ex) {
    } finally {
      setDataLodingIndicators(false);
    }
  }

  List<City> _getCities() => _allCities;

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

  @override
  void dispose() {
    for (var node in cityFocusNodes) {
      node.dispose();
    }
    nextButtonFocus.dispose();
    scrollController.dispose();
    super.dispose();
  }
}

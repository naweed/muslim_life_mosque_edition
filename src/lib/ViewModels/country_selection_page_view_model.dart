import 'package:flutter/material.dart';
import 'package:muslim_life_mosque_edition/Models/country.dart';
import 'package:muslim_life_mosque_edition/Shared/app_session.dart';
import 'package:muslim_life_mosque_edition/ViewModels/app_view_model.dart';

class CountrySelectionPageViewModel extends AppViewModel {
  late BuildContext screenContext;

  final FocusNode nextButtonFocus = FocusNode();
  final List<FocusNode> countryFocusNodes = [];

  final ScrollController scrollController = ScrollController();
  int _currentFocusIndex = 0;

  List<Country> _allCountries = [];
  List<Country> Countries = [];
  String SelectedCountry = "";

  CountrySelectionPageViewModel() : super() {
    this.Title = "Country Selection";
  }

  void requestFocus() async {
    if (Countries.isNotEmpty) {
      _currentFocusIndex = 0;

      FocusScope.of(screenContext).requestFocus(countryFocusNodes[0]);
      _scrollToFocusedItem();

      rebuildUi();
    }
  }

  void updateFocusNodes() {
    // Clear existing focus nodes
    for (var node in countryFocusNodes) {
      node.dispose();
    }

    countryFocusNodes.clear();

    // Create new focus nodes for each country
    for (var _ in Countries) {
      final node = FocusNode();

      node.addListener(() {
        if (node.hasFocus) {
          _currentFocusIndex = countryFocusNodes.indexOf(node);
          rebuildUi();
        }
      });

      countryFocusNodes.add(node);
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

      FocusScope.of(screenContext).requestFocus(countryFocusNodes[_currentFocusIndex]);
      _scrollToFocusedItem();

      rebuildUi();
    }
  }

  void moveFocusDown() {
    if (_currentFocusIndex < Countries.length - 1) {
      _currentFocusIndex++;

      FocusScope.of(screenContext).requestFocus(countryFocusNodes[_currentFocusIndex]);
      _scrollToFocusedItem();

      rebuildUi();
    }
  }

  bool isItemFocused(int index) {
    return _currentFocusIndex == index;
  }

  void _scrollToFocusedItem() {
    if (!scrollController.hasClients) return;

    final itemHeight = 78.0; // Height of each item including padding

    // Calculate the target position to center the focused item
    final targetPosition = _currentFocusIndex * itemHeight;
    final newPosition = targetPosition;

    // Ensure we don't scroll beyond the list boundaries
    final maxScroll = scrollController.position.maxScrollExtent;
    final boundedPosition = newPosition.clamp(0.0, maxScroll);

    // Use jumpTo for immediate response
    scrollController.jumpTo(boundedPosition);
  }

  Future<void> loadData() async {
    try {
      //Get Countries
      _allCountries = await appDataService.getAllCountries();
      Countries = _getCountries();

      updateFocusNodes();

      DataLoaded = true;
    } catch (ex) {
    } finally {
      rebuildUi();
    }
  }

  List<Country> _getCountries() => _allCountries;

  void setSelectedCountry(String countryCode) {
    if (countryCode == SelectedCountry) {
      SelectedCountry = "";
    } else {
      SelectedCountry = countryCode;

      var country = _allCountries.where((cntry) => cntry.id == countryCode).first;
      AppSession.Temp_PrayerCalculationMethod = country.pCalc;
      AppSession.Temp_AsrCalculationMethod = country.asrCalc;
    }

    rebuildUi();
  }

  @override
  void dispose() {
    for (var node in countryFocusNodes) {
      node.dispose();
    }
    nextButtonFocus.dispose();
    scrollController.dispose();
    super.dispose();
  }
}

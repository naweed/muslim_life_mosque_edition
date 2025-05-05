import 'package:flutter/material.dart';
import 'package:muslim_life_mosque_edition/Models/country.dart';
import 'package:muslim_life_mosque_edition/Shared/app_session.dart';
import 'package:muslim_life_mosque_edition/ViewModels/app_view_model.dart';

class CountrySelectionPageViewModel extends AppViewModel {
  List<Country> _allCountries = [];
  List<Country> Countries = [];
  String SelectedCountry = "";

  late TextEditingController CountrySearchController;

  CountrySelectionPageViewModel() : super() {
    this.Title = "Country Selection";
    CountrySearchController = TextEditingController();
  }

  Future<void> loadData() async {
    try {
      //Get Countries
      _allCountries = await appDataService.getAllCountries();
      Countries = _getCountries();

      DataLoaded = true;
    } catch (ex) {
    } finally {
      rebuildUi();
    }
  }

  Future<void> OnCountrySearchTextChanged() async {
    Countries = _getCountries();
    SelectedCountry = "";
    rebuildUi();
  }

  List<Country> _getCountries() {
    if (CountrySearchController.text.isEmpty) {
      return _allCountries;
    }

    return <Country>[
      ..._allCountries.where((cntry) => cntry.name!.toLowerCase().contains(CountrySearchController.text.toLowerCase())),
    ];
  }

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
}

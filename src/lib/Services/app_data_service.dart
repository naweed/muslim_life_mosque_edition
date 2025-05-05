import 'package:muslim_life_mosque_edition/Helpers/data_file_helpers.dart';
import 'package:muslim_life_mosque_edition/Models/city.dart';
import 'package:muslim_life_mosque_edition/Models/country.dart';

class AppDataService {
  //Get All Countries
  Future<List<Country>> getAllCountries() async {
    var tagObjsJson = await DataFileHelpers.loadJsonFromAssets("countries");

    return List<Country>.from(tagObjsJson.map((x) => Country.fromJson(x)));
  }

  //Get Cities
  Future<List<City>> getCities(String countryCode) async {
    var tagObjsJson = await DataFileHelpers.loadJsonFromAssets("cities/$countryCode");

    return List<City>.from(tagObjsJson.map((x) => City.fromJson(x)));
  }
}

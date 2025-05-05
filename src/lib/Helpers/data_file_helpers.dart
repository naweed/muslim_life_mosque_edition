import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:muslim_life_mosque_edition/Shared/app_constants.dart';

class DataFileHelpers {
  static Future<List<dynamic>> loadJsonFromAssets(String filePath) async {
    String jsonString = await rootBundle.loadString("${AppConstants.DataPath}/$filePath.json");
    return (jsonDecode(jsonString) as List);
  }
}

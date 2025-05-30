import 'dart:convert';

import 'package:muslim_life_mosque_edition/Framework/Extensions/string_extensions.dart';
import 'package:muslim_life_mosque_edition/Models/mosque.dart';
import 'package:muslim_life_mosque_edition/Services/app_settings_service.dart';
import 'package:muslim_life_mosque_edition/Services/cache_data_service.dart';
import 'package:muslim_life_mosque_edition/Services/muslim_life_http_client.dart';
import 'package:muslim_life_mosque_edition/Shared/app_constants.dart';

class AppApiService {
  late final CacheDataService cachedService;
  late final MuslimLifeHttpClient httpClient;
  late final AppSettingService appSettingsService;

  AppApiService() {
    cachedService = CacheDataService();
    httpClient = MuslimLifeHttpClient();
    appSettingsService = AppSettingService();
  }

  //Generic FetchData Class
  Future<String> _fetchData({required String resource, int hoursToCache = 0}) async {
    var resourceKey = resource.toCleanCacheKey();

    //Get data from cache
    var jsonData = await cachedService.getDataIfNotExpired(resourceKey);

    //Return Cached Data if available
    if (jsonData != null) {
      return jsonData;
    }

    //Cached Data not found. Fetch Fresh Data
    try {
      //Make API call
      var response = await httpClient.get(Uri.parse("${AppConstants.API_URL}$resource"));

      if (response.statusCode != 200) {
        //Throw error if no successful response is recieved
        throw Exception(
          'Either the Mosque Code is incorrect ot the Mosque is still not published. Please check the Majsid Pulse Portal for the correct code, and ensure that the mosque has been published.',
        );
      } else {
        await cachedService.saveDataWithExpiration(resourceKey, response.body, Duration(hours: hoursToCache));
        return response.body;
      }
    } catch (ex) {
      throw Exception(ex);
    }
  }

  //Get Mosque Details
  Future<Mosque> getMosqueDetails(String mosqueCode) async {
    var resourceUri = "mosque/get/$mosqueCode";

    var response = await _fetchData(resource: resourceUri, hoursToCache: 6); //Cached for 6 hours

    return Mosque.fromJson(jsonDecode(response));
  }
}

import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheDataService {
  final String keyPrefix = 'data_';
  final String expiryPrefix = 'expiry_';

  // Function to save data with an expiration date to SharedPreferences
  Future<bool> saveDataWithExpiration(String key, String data, Duration expirationDuration) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      DateTime expirationTime = DateTime.now().add(expirationDuration);

      await prefs.setString("$keyPrefix$key", data);
      await prefs.setString("$expiryPrefix$key", expirationTime.toIso8601String());

      return true;
    } catch (e) {
      return false;
    }
  }

  // Function to clear data from SharedPreferences
  Future<void> clearData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.clear();
      // ignore: empty_catches
    } catch (e) {}
  }

  // Function to get data from SharedPreferences if it's not expired
  Future<String?> getDataIfNotExpired(String key) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? data = prefs.getString("$keyPrefix$key");
      String? expirationTimeStr = prefs.getString("$expiryPrefix$key");

      if (data == null || expirationTimeStr == null) {
        return null; // No data or expiration time found.
      }

      DateTime expirationTime = DateTime.parse(expirationTimeStr);
      if (expirationTime.isAfter(DateTime.now())) {
        // The data has not expired.
        return data;
      } else {
        var internetConnected = await InternetConnection().hasInternetAccess;

        if (!internetConnected) {
          return data;
        }

        return null;
      }
    } catch (e) {
      // Error occured.
      return null;
    }
  }
}

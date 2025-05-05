import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/string_extensions.dart';
import 'package:muslim_life_mosque_edition/Framework/Helpers/secure_storage_helpers.dart';
import 'package:uuid/uuid.dart';

class AppSettingService {
  final String onboardingKey = "MosqueLife_OB_Completed";
  final String locationSelectionKey = "MosqueLife_LocSelection_Completed";
  final String guidKey = "MosqueLife_Guid";
  final String appStartDateKey = "MosqueLife_AppStartDate";
  final String myLocationKey = "MosqueLife_MyLocation";
  final String myLatitudeKey = "MosqueLife_MyLatitude";
  final String myLongitudeKey = "MosqueLife_MyLongitude";
  final String myPrayerCalcMethodKey = "MosqueLife_MyPrayerCalcMethod";
  final String myAsrCalcMethodKey = "MosqueLife_MyAsrCalcMethod";

  final String myFajrAdjustmentKey = "MosqueLife_MyFajrAdjustment";
  final String myDhuhrAdjustmentKey = "MosqueLife_MyDhuhrAdjustment";
  final String myAsrAdjustmentKey = "MosqueLife_MyAsrAdjustment";
  final String myMaghribAdjustmentKey = "MosqueLife_MyMaghribAdjustment";
  final String myIshaAdjustmentKey = "MosqueLife_MyIshaAdjustment";
  final String mySunriseAdjustmentKey = "MosqueLife_MySunriseAdjustment";

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock, synchronizable: true),
  );

  //Onboarding Status
  Future<bool> getOnboardingCompleted() async {
    if (!(await SecureStorageHelpers.checkKeyExists(_secureStorage, onboardingKey))) {
      await SecureStorageHelpers.writeKeyValue(_secureStorage, onboardingKey, "false");
    }

    return (await SecureStorageHelpers.readKeyValue(_secureStorage, onboardingKey))!.toBoolean();
  }

  Future<void> saveOnboardingCompleted() async =>
      await SecureStorageHelpers.writeKeyValue(_secureStorage, onboardingKey, "true");

  //Location Selection Status
  Future<bool> getLocationSelectionCompleted() async {
    if (!(await SecureStorageHelpers.checkKeyExists(_secureStorage, locationSelectionKey))) {
      await SecureStorageHelpers.writeKeyValue(_secureStorage, locationSelectionKey, "false");
    }

    return (await SecureStorageHelpers.readKeyValue(_secureStorage, locationSelectionKey))!.toBoolean();
  }

  Future<void> saveLocationSelectionCompleted() async =>
      await SecureStorageHelpers.writeKeyValue(_secureStorage, locationSelectionKey, "true");

  //Unique App Key
  Future<String> getAppUniqueKey() async {
    if (!(await SecureStorageHelpers.checkKeyExists(_secureStorage, guidKey))) {
      await SecureStorageHelpers.writeKeyValue(_secureStorage, guidKey, Uuid().v4().toString());
    }

    return (await SecureStorageHelpers.readKeyValue(_secureStorage, guidKey)) ?? "";
  }

  //App Start Date
  Future<String> getAppStartDate() async {
    if (!(await SecureStorageHelpers.checkKeyExists(_secureStorage, appStartDateKey))) {
      await SecureStorageHelpers.writeKeyValue(_secureStorage, appStartDateKey, DateTime.now().toString());
    }

    return (await SecureStorageHelpers.readKeyValue(_secureStorage, appStartDateKey)) ?? "";
  }

  //My Location
  Future<String> getMyLocation() async {
    if (!(await SecureStorageHelpers.checkKeyExists(_secureStorage, myLocationKey))) {
      await SecureStorageHelpers.writeKeyValue(_secureStorage, myLocationKey, "My Location");
    }

    return (await SecureStorageHelpers.readKeyValue(_secureStorage, myLocationKey))!;
  }

  Future<void> saveMyLocation(String myNewLocation) async =>
      await SecureStorageHelpers.writeKeyValue(_secureStorage, myLocationKey, myNewLocation);

  //My Latitude
  Future<double> getMyLatitude() async {
    if (!(await SecureStorageHelpers.checkKeyExists(_secureStorage, myLatitudeKey))) {
      await SecureStorageHelpers.writeKeyValue(_secureStorage, myLatitudeKey, "0.0");
    }

    return double.parse((await SecureStorageHelpers.readKeyValue(_secureStorage, myLatitudeKey))!);
  }

  Future<void> saveMyLatitude(double myNewLatitude) async =>
      await SecureStorageHelpers.writeKeyValue(_secureStorage, myLatitudeKey, myNewLatitude.toString());

  //My Longitude
  Future<double> getMyLongitude() async {
    if (!(await SecureStorageHelpers.checkKeyExists(_secureStorage, myLongitudeKey))) {
      await SecureStorageHelpers.writeKeyValue(_secureStorage, myLongitudeKey, "0.0");
    }

    return double.parse((await SecureStorageHelpers.readKeyValue(_secureStorage, myLongitudeKey))!);
  }

  Future<void> saveMyLongitude(double myNewLongitude) async =>
      await SecureStorageHelpers.writeKeyValue(_secureStorage, myLongitudeKey, myNewLongitude.toString());

  //My Prayer Calculation Method
  Future<String> getMyPrayerCalcMethod() async {
    if (!(await SecureStorageHelpers.checkKeyExists(_secureStorage, myPrayerCalcMethodKey))) {
      await SecureStorageHelpers.writeKeyValue(_secureStorage, myPrayerCalcMethodKey, "Muslim World League");
    }

    return (await SecureStorageHelpers.readKeyValue(_secureStorage, myPrayerCalcMethodKey))!;
  }

  Future<void> saveMyPrayerCalcMethod(String myNewPrayerCalcMethod) async =>
      await SecureStorageHelpers.writeKeyValue(_secureStorage, myPrayerCalcMethodKey, myNewPrayerCalcMethod);

  //My Asr Calculation Method
  Future<String> getMyAsrCalcMethod() async {
    if (!(await SecureStorageHelpers.checkKeyExists(_secureStorage, myAsrCalcMethodKey))) {
      await SecureStorageHelpers.writeKeyValue(_secureStorage, myAsrCalcMethodKey, "Shafi");
    }

    return (await SecureStorageHelpers.readKeyValue(_secureStorage, myAsrCalcMethodKey))!;
  }

  Future<void> saveMyAsrCalcMethod(String myNewAsrCalcMethod) async =>
      await SecureStorageHelpers.writeKeyValue(_secureStorage, myAsrCalcMethodKey, myNewAsrCalcMethod);

  //My Fajr Adjustment
  Future<int> getMyFajrAdjustment() async {
    if (!(await SecureStorageHelpers.checkKeyExists(_secureStorage, myFajrAdjustmentKey))) {
      await SecureStorageHelpers.writeKeyValue(_secureStorage, myFajrAdjustmentKey, "0");
    }

    return int.parse((await SecureStorageHelpers.readKeyValue(_secureStorage, myFajrAdjustmentKey))!);
  }

  Future<void> saveMyFajrAdjustment(int newValue) async =>
      await SecureStorageHelpers.writeKeyValue(_secureStorage, myFajrAdjustmentKey, newValue.toString());

  //My Dhuhr Adjustment
  Future<int> getMyDhuhrAdjustment() async {
    if (!(await SecureStorageHelpers.checkKeyExists(_secureStorage, myDhuhrAdjustmentKey))) {
      await SecureStorageHelpers.writeKeyValue(_secureStorage, myDhuhrAdjustmentKey, "0");
    }

    return int.parse((await SecureStorageHelpers.readKeyValue(_secureStorage, myDhuhrAdjustmentKey))!);
  }

  Future<void> saveMyDhuhrAdjustment(int newValue) async =>
      await SecureStorageHelpers.writeKeyValue(_secureStorage, myDhuhrAdjustmentKey, newValue.toString());

  //My Asr Adjustment
  Future<int> getMyAsrAdjustment() async {
    if (!(await SecureStorageHelpers.checkKeyExists(_secureStorage, myAsrAdjustmentKey))) {
      await SecureStorageHelpers.writeKeyValue(_secureStorage, myAsrAdjustmentKey, "0");
    }

    return int.parse((await SecureStorageHelpers.readKeyValue(_secureStorage, myAsrAdjustmentKey))!);
  }

  Future<void> saveMyAsrAdjustment(int newValue) async =>
      await SecureStorageHelpers.writeKeyValue(_secureStorage, myAsrAdjustmentKey, newValue.toString());

  //My Maghrib Adjustment
  Future<int> getMyMaghribAdjustment() async {
    if (!(await SecureStorageHelpers.checkKeyExists(_secureStorage, myMaghribAdjustmentKey))) {
      await SecureStorageHelpers.writeKeyValue(_secureStorage, myMaghribAdjustmentKey, "0");
    }

    return int.parse((await SecureStorageHelpers.readKeyValue(_secureStorage, myMaghribAdjustmentKey))!);
  }

  Future<void> saveMyMaghribAdjustment(int newValue) async =>
      await SecureStorageHelpers.writeKeyValue(_secureStorage, myMaghribAdjustmentKey, newValue.toString());

  //My Isha Adjustment
  Future<int> getMyIshaAdjustment() async {
    if (!(await SecureStorageHelpers.checkKeyExists(_secureStorage, myIshaAdjustmentKey))) {
      await SecureStorageHelpers.writeKeyValue(_secureStorage, myIshaAdjustmentKey, "0");
    }

    return int.parse((await SecureStorageHelpers.readKeyValue(_secureStorage, myIshaAdjustmentKey))!);
  }

  Future<void> saveMyIshaAdjustment(int newValue) async =>
      await SecureStorageHelpers.writeKeyValue(_secureStorage, myIshaAdjustmentKey, newValue.toString());

  //My Sunrise Adjustment
  Future<int> getMySunriseAdjustment() async {
    if (!(await SecureStorageHelpers.checkKeyExists(_secureStorage, mySunriseAdjustmentKey))) {
      await SecureStorageHelpers.writeKeyValue(_secureStorage, mySunriseAdjustmentKey, "0");
    }

    return int.parse((await SecureStorageHelpers.readKeyValue(_secureStorage, mySunriseAdjustmentKey))!);
  }

  Future<void> saveMySunriseAdjustment(int newValue) async =>
      await SecureStorageHelpers.writeKeyValue(_secureStorage, mySunriseAdjustmentKey, newValue.toString());

  //Clear all preferences
  Future<void> clearAllPreferences() async => await _secureStorage.deleteAll();
}

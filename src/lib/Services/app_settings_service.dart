import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:muslim_life_mosque_edition/Framework/Extensions/string_extensions.dart';
import 'package:muslim_life_mosque_edition/Framework/Helpers/secure_storage_helpers.dart';
import 'package:uuid/uuid.dart';

class AppSettingService {
  final String onboardingKey = "MosqueLife_OB_Completed";
  final String mosqueCodeSelectionKey = "MosqueLife_MCodeSelection_Completed";
  final String mosqueCodeKey = "MosqueLife_Mosque_Code";
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
  );

  //Clear all preferences
  Future<void> clearAllPreferences() async => await _secureStorage.deleteAll();

  //Onboarding Status
  Future<bool> getOnboardingCompleted() async {
    if (!(await SecureStorageHelpers.checkKeyExists(_secureStorage, onboardingKey))) {
      await SecureStorageHelpers.writeKeyValue(_secureStorage, onboardingKey, "false");
    }

    return (await SecureStorageHelpers.readKeyValue(_secureStorage, onboardingKey))!.toBoolean();
  }

  Future<void> saveOnboardingCompleted() async =>
      await SecureStorageHelpers.writeKeyValue(_secureStorage, onboardingKey, "true");

  //Mosque Code Selection Status
  Future<bool> getMosqueCodeSelectionCompleted() async {
    if (!(await SecureStorageHelpers.checkKeyExists(_secureStorage, mosqueCodeSelectionKey))) {
      await SecureStorageHelpers.writeKeyValue(_secureStorage, mosqueCodeSelectionKey, "false");
    }

    return (await SecureStorageHelpers.readKeyValue(_secureStorage, mosqueCodeSelectionKey))!.toBoolean();
  }

  Future<void> saveMosqueCodeSelectionCompleted() async =>
      await SecureStorageHelpers.writeKeyValue(_secureStorage, mosqueCodeSelectionKey, "true");

  //Mosque Code
  Future<String> getMosqueCode() async {
    if (!(await SecureStorageHelpers.checkKeyExists(_secureStorage, mosqueCodeKey))) {
      await SecureStorageHelpers.writeKeyValue(_secureStorage, mosqueCodeKey, "");
    }

    return (await SecureStorageHelpers.readKeyValue(_secureStorage, mosqueCodeKey)) ?? "";
  }

  Future<void> saveMosqueCode(String mosqueCode) async =>
      await SecureStorageHelpers.writeKeyValue(_secureStorage, mosqueCodeKey, mosqueCode);

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
}

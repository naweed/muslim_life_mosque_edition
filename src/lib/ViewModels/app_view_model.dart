import 'package:muslim_life_mosque_edition/Services/app_settings_service.dart';
import 'package:stacked/stacked.dart';

class AppViewModel extends BaseViewModel {
  late AppApiService appApiService;
  late AppSettingService appSettingsService;
  late AppDatabaseService appDatabaseService;
  late AppDataService appDataService;

  String Title = "";
  bool IsBusy = false;
  String LoadingText = "";
  bool DataLoaded = false;
  bool IsErrorState = false;
  String ErrorMessage = "";
  String ErrorImage = "";

  AppViewModel() {
    appApiService = AppApiService();
    appSettingsService = AppSettingService();
    appDatabaseService = AppDatabaseService();
    appDataService = AppDataService();
  }

  void setDataLodingIndicators(bool isStaring) {
    if (isStaring) {
      IsBusy = true;
      DataLoaded = false;
      IsErrorState = false;
      ErrorMessage = "";
      ErrorImage = "";
    } else {
      LoadingText = "";
      IsBusy = false;
    }

    rebuildUi();
  }
}

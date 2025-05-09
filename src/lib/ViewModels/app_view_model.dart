import 'package:muslim_life_mosque_edition/Services/app_data_service.dart';
import 'package:muslim_life_mosque_edition/Services/app_settings_service.dart';
import 'package:stacked/stacked.dart';

class AppViewModel extends BaseViewModel {
  late AppSettingService appSettingsService;
  late AppDataService appDataService;

  String Title = "";
  bool IsBusy = false;
  String LoadingText = "";
  bool DataLoaded = false;
  bool IsErrorState = false;
  String ErrorMessage = "";
  String ErrorImage = "";

  AppViewModel() {
    appSettingsService = AppSettingService();
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

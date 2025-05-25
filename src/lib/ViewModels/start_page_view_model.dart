import 'package:flutter/material.dart';
import 'package:muslim_life_mosque_edition/Models/mosque.dart';
import 'package:muslim_life_mosque_edition/Services/app_api_service.dart';
import 'package:muslim_life_mosque_edition/Shared/app_constants.dart';
import 'package:muslim_life_mosque_edition/ViewModels/app_view_model.dart';

class StartPageViewModel extends AppViewModel {
  late BuildContext screenContext;
  late String mosqueCode;
  late Mosque mosque;

  StartPageViewModel() : super() {
    this.Title = "Prayer Times";

    appApiService = AppApiService();
  }

  Future<void> loadData() async {
    try {
      LoadingText = "";
      setDataLodingIndicators(true);

      //Load the Mosque Details
      mosqueCode = await appSettingsService.getMosqueCode();
      mosque = await appApiService.getMosqueDetails(mosqueCode);

      DataLoaded = true;
    } catch (ex) {
      IsErrorState = true;
      ErrorMessage =
          "Something went wrong. If the problem persists, plz contact support at ${AppConstants.SupportEmailAddress}.";
    } finally {
      setDataLodingIndicators(false);
    }
  }
}

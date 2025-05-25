import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:muslim_life_mosque_edition/Helpers/hijri_date_helper.dart';
import 'package:muslim_life_mosque_edition/Models/mosque.dart';
import 'package:muslim_life_mosque_edition/Services/app_api_service.dart';
import 'package:muslim_life_mosque_edition/Shared/app_constants.dart';
import 'package:muslim_life_mosque_edition/ViewModels/app_view_model.dart';

class StartPageViewModel extends AppViewModel {
  late BuildContext screenContext;
  late String mosqueCode;
  late Mosque mosque;

  late DateTime _currentDateGregorian;
  late String CurrentDateHijri;
  late String CurrentTime;
  String get CurrentDateGregorian => DateFormat('EEEE, MMM d, yyyy').format(_currentDateGregorian);

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

      //Get Curent Date
      getCurrentDate();

      //Set the Time and Start Timer
      setCurrentTime();
      Timer.periodic(1.seconds, (Timer t) {
        setCurrentTime();
        rebuildUi();
      });

      DataLoaded = true;
    } catch (ex) {
      IsErrorState = true;
      ErrorMessage =
          "Something went wrong. If the problem persists, plz contact support at ${AppConstants.SupportEmailAddress}.";
    } finally {
      setDataLodingIndicators(false);
    }
  }

  void setCurrentTime() {
    CurrentTime = DateFormat('hh:mm:ss a').format(DateTime.now());
  }

  void getCurrentDate() {
    //Get Current Date
    var (currDate, hijriDate) = HijriDateHelper.getCurrentDates();
    _currentDateGregorian = currDate;
    CurrentDateHijri = hijriDate;
  }
}

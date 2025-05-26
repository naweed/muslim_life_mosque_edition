import 'dart:async';

import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:muslim_life_mosque_edition/Helpers/hijri_date_helper.dart';
import 'package:muslim_life_mosque_edition/Helpers/prayer_times_helper.dart';
import 'package:muslim_life_mosque_edition/Models/app_prayer_time.dart';
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

  PrayerTimes? PrayTimes;
  List<AppPrayerTime> AllPrayerTimes = [
    AppPrayerTime(prayerName: "Fajr", prayerTime: DateTime.now(), isCurrent: true, isNext: false),
    AppPrayerTime(prayerName: "Dhuhr", prayerTime: DateTime.now(), isCurrent: false, isNext: true),
    AppPrayerTime(prayerName: "Asr", prayerTime: DateTime.now(), isCurrent: false, isNext: false),
    AppPrayerTime(prayerName: "Maghrib", prayerTime: DateTime.now(), isCurrent: false, isNext: false),
    AppPrayerTime(prayerName: "Isha", prayerTime: DateTime.now(), isCurrent: false, isNext: false),
    AppPrayerTime(prayerName: "Sunrise", prayerTime: DateTime.now(), isCurrent: false, isNext: false),
  ];

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

      //Get Today's Prayer Times
      await getTodaysPrayerTimes();

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

  Future<void> getTodaysPrayerTimes() async {
    //Get Prayer Times
    PrayTimes = await PrayerTimesHelper.getPrayerTimes(
      theDate: _currentDateGregorian,
      userLat: mosque.latitude!,
      userLon: mosque.longitude!,
      prayerCalcMethod: mosque.prayerCalcMethod!,
      asrCalculationMethod: mosque.asrCalcMethod!,
      fajrAdjustment: mosque.adjustmentFajr!,
      sunriseAdjustment: mosque.adjustmentSunrise!,
      dhuhrAdjustment: mosque.adjustmentDhuhr!,
      asrAdjustment: mosque.adjustmentAsr!,
      maghribAdjustment: mosque.adjustmentMaghrib!,
      ishaAdjustment: mosque.adjustmentIsha!,
    );

    ////TODO
    // //Get Next Prayer Time
    // var (nextPrayerName, nextPrayerTime) = await PrayerTimesHelper.getNextPrayer(PrayTimes!, _currentDateGregorian);
    // NextPrayerName = nextPrayerName;
    // NextPrayerTime = nextPrayerTime;

    // try {
    //   countrDownController.dispose();
    // } catch (ex) {}

    // countrDownController = CountdownTimerController(endTime: NextPrayerTime.millisecondsSinceEpoch, onEnd: reloadData);
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

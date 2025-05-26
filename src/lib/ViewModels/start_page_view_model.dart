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

  DateTime _currentPrayerTime = DateTime.now();
  String NextPrayerName = "";
  DateTime NextPrayerTime = DateTime.now().add(10000.milliseconds);

  PrayerTimes? PrayTimes;
  List<AppPrayerTime> AllPrayerTimes = [
    AppPrayerTime(prayerName: "", prayerTime: DateTime.now(), isCurrent: true, isNext: false),
    AppPrayerTime(prayerName: "", prayerTime: DateTime.now(), isCurrent: false, isNext: true),
    AppPrayerTime(prayerName: "", prayerTime: DateTime.now(), isCurrent: false, isNext: false),
    AppPrayerTime(prayerName: "", prayerTime: DateTime.now(), isCurrent: false, isNext: false),
    AppPrayerTime(prayerName: "", prayerTime: DateTime.now(), isCurrent: false, isNext: false),
    AppPrayerTime(prayerName: "", prayerTime: DateTime.now(), isCurrent: false, isNext: false),
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

    //Get Current Prayer at the moment
    await getCurrentPrayer();

    //Get Next Prayer Time
    var (nextPrayerName, nextPrayerTime, isSameDay) = await PrayerTimesHelper.getNextPrayer(
      prayers: PrayTimes!,
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

    NextPrayerName = nextPrayerName;
    NextPrayerTime = nextPrayerTime;

    AllPrayerTimes.clear();

    AllPrayerTimes.add(
      AppPrayerTime(
        prayerName: "Fajr",
        prayerTime: PrayTimes!.fajr,
        isCurrent: _currentPrayerTime.compareTo(PrayTimes!.fajr) == 0,
        isNext: isSameDay && nextPrayerName == "Fajr",
      ),
    );
    AllPrayerTimes.add(
      AppPrayerTime(
        prayerName: "Dhuhr",
        prayerTime: PrayTimes!.dhuhr,
        isCurrent: _currentPrayerTime.compareTo(PrayTimes!.dhuhr) == 0,
        isNext: isSameDay && nextPrayerName == "Dhuhr",
      ),
    );
    AllPrayerTimes.add(
      AppPrayerTime(
        prayerName: "Asr",
        prayerTime: PrayTimes!.asr,
        isCurrent: _currentPrayerTime.compareTo(PrayTimes!.asr) == 0,
        isNext: isSameDay && nextPrayerName == "Asr",
      ),
    );
    AllPrayerTimes.add(
      AppPrayerTime(
        prayerName: "Maghrib",
        prayerTime: PrayTimes!.maghrib,
        isCurrent: _currentPrayerTime.compareTo(PrayTimes!.maghrib) == 0,
        isNext: isSameDay && nextPrayerName == "Maghrib",
      ),
    );
    AllPrayerTimes.add(
      AppPrayerTime(
        prayerName: "Isha",
        prayerTime: PrayTimes!.isha,
        isCurrent: _currentPrayerTime.compareTo(PrayTimes!.isha) == 0,
        isNext: isSameDay && nextPrayerName == "Isha",
      ),
    );
    AllPrayerTimes.add(
      AppPrayerTime(
        prayerName: "Shuruq",
        prayerTime: PrayTimes!.sunrise,
        isCurrent: _currentPrayerTime.compareTo(PrayTimes!.sunrise) == 0,
        isNext: isSameDay && nextPrayerName == "Shuruq",
      ),
    );

    //TODO: Counter
    // try {
    //   countrDownController.dispose();
    // } catch (ex) {}

    // countrDownController = CountdownTimerController(endTime: NextPrayerTime.millisecondsSinceEpoch, onEnd: reloadData);
  }

  Future<void> getCurrentPrayer() async {
    //Get Current Prayer Time
    var (currentPrayerName, currentPrayerTime) = await PrayerTimesHelper.getCurrentPrayer(
      PrayTimes!,
      _currentDateGregorian,
    );

    _currentPrayerTime = currentPrayerTime;
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

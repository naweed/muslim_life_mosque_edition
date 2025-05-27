import 'dart:async';

import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
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

  late CountdownTimerController countrDownController;
  late Timer clockTimer;

  late DateTime _currentDateGregorian;
  late String CurrentDateHijri;
  late String CurrentTime;
  String get CurrentDateGregorian => DateFormat('EEEE, MMM d, yyyy').format(_currentDateGregorian);

  String CurrentPrayerName = "";
  DateTime CurrentPrayerTime = DateTime.now();
  String NextPrayerName = "";
  DateTime NextPrayerTime = DateTime.now().add(10000.milliseconds);
  String NextPrayerDisplayName1 = "Next Prayer";
  String NextPrayerDisplayName2 = " ASR ";

  PrayerTimes? PrayTimes;
  List<AppPrayerTime> AllPrayerTimes = [
    AppPrayerTime(
      prayerName: "",
      prayerTime: DateTime.now(),
      isCurrent: true,
      isNext: false,
      iqamaTime: DateTime.now(),
    ),
    AppPrayerTime(
      prayerName: "",
      prayerTime: DateTime.now(),
      isCurrent: false,
      isNext: false,
      iqamaTime: DateTime.now(),
    ),
    AppPrayerTime(
      prayerName: "",
      prayerTime: DateTime.now(),
      isCurrent: false,
      isNext: false,
      iqamaTime: DateTime.now(),
    ),
    AppPrayerTime(
      prayerName: "",
      prayerTime: DateTime.now(),
      isCurrent: false,
      isNext: false,
      iqamaTime: DateTime.now(),
    ),
    AppPrayerTime(
      prayerName: "",
      prayerTime: DateTime.now(),
      isCurrent: false,
      isNext: false,
      iqamaTime: DateTime.now(),
    ),
    AppPrayerTime(
      prayerName: "",
      prayerTime: DateTime.now(),
      isCurrent: false,
      isNext: false,
      iqamaTime: DateTime.now(),
    ),
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
      setTimer();

      DataLoaded = true;
    } catch (ex) {
      IsErrorState = true;
      ErrorMessage =
          "Something went wrong. If the problem persists, plz contact support at ${AppConstants.SupportEmailAddress}.";
    } finally {
      setDataLodingIndicators(false);
    }
  }

  void setTimer() {
    try {
      clockTimer.cancel();
    } catch (ex) {}

    clockTimer = Timer.periodic(1.seconds, (Timer t) {
      setCurrentTime();
      rebuildUi();
    });
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
        isCurrent: CurrentPrayerTime.compareTo(PrayTimes!.fajr) == 0,
        isNext: isSameDay && nextPrayerName == "Fajr",
        iqamaTime: PrayTimes!.fajr.add(mosque.adjustmentFajrIqamah!.minutes),
      ),
    );
    AllPrayerTimes.add(
      AppPrayerTime(
        prayerName: "Dhuhr",
        prayerTime: PrayTimes!.dhuhr,
        isCurrent: CurrentPrayerTime.compareTo(PrayTimes!.dhuhr) == 0,
        isNext: isSameDay && nextPrayerName == "Dhuhr",
        iqamaTime: PrayTimes!.dhuhr.add(mosque.adjustmentDhuhrIqamah!.minutes),
      ),
    );
    AllPrayerTimes.add(
      AppPrayerTime(
        prayerName: "Asr",
        prayerTime: PrayTimes!.asr,
        isCurrent: CurrentPrayerTime.compareTo(PrayTimes!.asr) == 0,
        isNext: isSameDay && nextPrayerName == "Asr",
        iqamaTime: PrayTimes!.asr.add(mosque.adjustmentAsrIqamah!.minutes),
      ),
    );
    AllPrayerTimes.add(
      AppPrayerTime(
        prayerName: "Maghrib",
        prayerTime: PrayTimes!.maghrib,
        isCurrent: CurrentPrayerTime.compareTo(PrayTimes!.maghrib) == 0,
        isNext: isSameDay && nextPrayerName == "Maghrib",
        iqamaTime: PrayTimes!.maghrib.add(mosque.adjustmentMaghribIqamah!.minutes),
      ),
    );
    AllPrayerTimes.add(
      AppPrayerTime(
        prayerName: "Isha",
        prayerTime: PrayTimes!.isha,
        isCurrent: CurrentPrayerTime.compareTo(PrayTimes!.isha) == 0,
        isNext: isSameDay && nextPrayerName == "Isha",
        iqamaTime: PrayTimes!.isha.add(mosque.adjustmentIshaIqamah!.minutes),
      ),
    );
    AllPrayerTimes.add(
      AppPrayerTime(
        prayerName: "Shuruq",
        prayerTime: PrayTimes!.sunrise,
        isCurrent: CurrentPrayerTime.compareTo(PrayTimes!.sunrise) == 0,
        isNext: isSameDay && nextPrayerName == "Shuruq",
        iqamaTime: PrayTimes!.sunrise,
      ),
    );

    if (!AllPrayerTimes.any((prayer) => prayer.isNext)) {
      //No Same day prayer
      NextPrayerDisplayName1 = "Next Prayer (tomorrow) ";
      NextPrayerDisplayName2 = NextPrayerName.toUpperCase();
    } else if (AllPrayerTimes.any((prayer) => prayer.prayerName == "Shuruq" && prayer.isNext)) {
      //Shuruq Prayer
      NextPrayerDisplayName1 = "";
      NextPrayerDisplayName2 = NextPrayerName.toUpperCase();
    } else if (AllPrayerTimes.any((prayer) => prayer.isCurrent && DateTime.now().isBefore(prayer.iqamaTime))) {
      //Iqama Times
      NextPrayerDisplayName1 = "";
      NextPrayerDisplayName2 = "Iqama ";
      NextPrayerTime = AllPrayerTimes.where(
        (prayer) => prayer.isCurrent && DateTime.now().isBefore(prayer.iqamaTime),
      ).first.iqamaTime;
    } else {
      //Next Adhan Times
      NextPrayerDisplayName1 = "Next Prayer ";
      NextPrayerDisplayName2 = NextPrayerName.toUpperCase();
    }

    //Set Counter
    try {
      countrDownController.dispose();
    } catch (ex) {}

    countrDownController = CountdownTimerController(endTime: NextPrayerTime.millisecondsSinceEpoch, onEnd: reloadData);
  }

  Future<void> reloadData() async {
    Future.delayed(5.seconds, () async {
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

        //Set Clock Timer
        setTimer();

        DataLoaded = true;
      } catch (ex) {
        IsErrorState = true;
        ErrorMessage =
            "Something went wrong. If the problem persists, plz contact support at ${AppConstants.SupportEmailAddress}.";
      } finally {
        setDataLodingIndicators(false);
      }
    });
  }

  Future<void> getCurrentPrayer() async {
    //Get Current Prayer Time
    var (currentPrayerName, currentPrayerTime) = await PrayerTimesHelper.getCurrentPrayer(
      PrayTimes!,
      _currentDateGregorian,
    );

    CurrentPrayerTime = currentPrayerTime;
    CurrentPrayerName = currentPrayerName;
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

import 'package:adhan/adhan.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:intl/intl.dart';
import 'package:muslimlife/Events/prayer_setting_event.dart';
import 'package:muslimlife/Events/prayer_status_event.dart';
import 'package:muslimlife/Framework/Helpers/toast_helpers.dart';
import 'package:muslimlife/Helpers/hijri_date_helper.dart';
import 'package:muslimlife/Helpers/prayer_times_helper.dart';
import 'package:muslimlife/Models/db_models.dart';
import 'package:muslimlife/Models/prayer_models.dart';
import 'package:muslimlife/Shared/app_constants.dart';
import 'package:muslimlife/ViewModels/app_view_model.dart';
import 'package:share_plus/share_plus.dart';
import 'package:synchronized/synchronized.dart';

class HomeTimesPageViewModel extends AppViewModel {
  final EventBus eventBus;

  //Header Related
  late String CurrentDateHijri;
  late String MyLocation;
  String NextPrayerName = "";
  DateTime NextPrayerTime = DateTime.now().add(10000.milliseconds);
  DateTime _currentPrayerTime = DateTime.now();

  late DateTime _currentDateGregorian;
  String get CurrentDateGregorian => DateFormat('EEEE MMM d, yyyy').format(_currentDateGregorian);

  PrayerTimes? PrayTimes;

  //Prayer Times Related
  List<(DateTime, String, List<AppPrayerTime>)> Dates = [];
  List<AppPrayerTime> AllPrayerTimes = [
    AppPrayerTime(prayerName: "", prayerTime: DateTime.now(), isPrayed: false, isCurrent: false),
    AppPrayerTime(prayerName: "", prayerTime: DateTime.now(), isPrayed: false, isCurrent: false),
    AppPrayerTime(prayerName: "", prayerTime: DateTime.now(), isPrayed: false, isCurrent: false),
    AppPrayerTime(prayerName: "", prayerTime: DateTime.now(), isPrayed: false, isCurrent: false),
    AppPrayerTime(prayerName: "", prayerTime: DateTime.now(), isPrayed: false, isCurrent: false),
    AppPrayerTime(prayerName: "", prayerTime: DateTime.now(), isPrayed: false, isCurrent: false),
  ];

  int currentDateIndex = 5;
  late CarouselSliderController buttonCarouselController;

  late CountdownTimerController countrDownController;

  final _lock = Lock();

  HomeTimesPageViewModel(this.eventBus) : super() {
    this.Title = AppConstants.ApplicationName;
    MyLocation = "My Location";
    buttonCarouselController = CarouselSliderController();

    countrDownController = CountdownTimerController(endTime: NextPrayerTime.millisecondsSinceEpoch, onEnd: reloadData);

    //Listen to PrayerSettingEvent
    eventBus.on<PrayerSettingEvent>().listen((event) {
      _lock.synchronized(() async {
        await loadData();
      });
    });
  }

  Future<void> loadData() async {
    currentDateIndex = 5;

    LoadingText = "";
    setDataLodingIndicators(true);

    try {
      getCurrentDate();

      //Get My Location
      MyLocation = await appSettingsService.getMyLocation();

      //Get Current Prayer Time
      await getCurrentPrayerTimes();

      //Get Current Prayer at the moment
      await getCurrentPrayer();

      //Get All Prayer Times
      await getDatesAndPrayerTimes();

      setCurrentIndex(currentDateIndex);

      DataLoaded = true;
    } catch (ex) {
      IsErrorState = true;
      ErrorMessage =
          "Something went wrong. If the problem persists, plz contact support at ${AppConstants.SupportEmailAddress}.";
    } finally {
      setDataLodingIndicators(false);
    }
  }

  Future<void> getCurrentPrayerTimes() async {
    //Get Prayer Times
    PrayTimes = await PrayerTimesHelper.getPrayerTimes(_currentDateGregorian);

    //Get Next Prayer Time
    var (nextPrayerName, nextPrayerTime) = await PrayerTimesHelper.getNextPrayer(PrayTimes!, _currentDateGregorian);
    NextPrayerName = nextPrayerName;
    NextPrayerTime = nextPrayerTime;

    try {
      countrDownController.dispose();
    } catch (ex) {}

    countrDownController = CountdownTimerController(endTime: NextPrayerTime.millisecondsSinceEpoch, onEnd: reloadData);

    setDataLodingIndicators(false);
  }

  Future<void> getCurrentPrayer() async {
    //Get Current Prayer Time
    var (currentPrayerName, currentPrayerTime) = await PrayerTimesHelper.getCurrentPrayer(
      PrayTimes!,
      _currentDateGregorian,
    );
    _currentPrayerTime = currentPrayerTime;
  }

  void getCurrentDate() {
    //Get Current Date
    var (currDate, hijriDate) = HijriDateHelper.getCurrentDates();
    _currentDateGregorian = currDate;
    CurrentDateHijri = hijriDate;
  }

  Future<void> reloadData() async {
    Future.delayed(3.seconds, () async {
      getCurrentDate();

      await getCurrentPrayerTimes();

      await getCurrentPrayer();

      await getDatesAndPrayerTimes();

      setCurrentIndex(currentDateIndex);

      eventBus.fire(PrayerStatusEvent());
    });
  }

  void setCurrentIndex(int index) {
    currentDateIndex = index;
    AllPrayerTimes.clear();

    AllPrayerTimes.addAll(Dates[index].$3);

    rebuildUi();
  }

  Future<void> markPrayerStatus(BuildContext context, DateTime theDate, String prayerName, bool isPrayed) async {
    if (theDate.compareTo(DateTime.now()) > 0) {
      ToastHelpers.showMediumToast(context, "It is not prayer time yet!", isError: true);

      return;
    }

    var prayedPrayers = await appDatabaseService.getTrackedPrayersForDay(DateFormat('yyyy-MM-dd').format(theDate));

    if (prayedPrayers.any((x) => (x.Prayer_Name == prayerName))) {
      var trackedPrayer = prayedPrayers.where((x) => (x.Prayer_Name == prayerName)).first;
      trackedPrayer.Is_Prayed = isPrayed;
      await appDatabaseService.updateTrackedPrayer(trackedPrayer);
    } else {
      var trackedPrayer = TrackedPrayer(
        Prayer_Date: DateFormat('yyyy-MM-dd').format(theDate),
        Prayer_Name: prayerName,
        Is_Prayed: isPrayed,
      );
      await appDatabaseService.insertTrackedPrayer(trackedPrayer);
    }

    //Set the status of the Prayer
    AllPrayerTimes.where((prayer) => prayer.prayerName == prayerName).first.isPrayed = isPrayed;

    rebuildUi();

    ToastHelpers.showShortToast(context, "Prayer status saved successfully!");

    eventBus.fire(PrayerStatusEvent());
  }

  Future<void> getDatesAndPrayerTimes() async {
    Dates.clear();

    for (int i = -5; i <= 5; i++) {
      //Get Dates
      var (currDate, hijriDate) = HijriDateHelper.getDates(DateTime.now().add(Duration(days: i)));

      var prayerTimes = await PrayerTimesHelper.getPrayerTimes(currDate);

      List<AppPrayerTime> prayersList = [];

      var prayedPrayers = await appDatabaseService.getTrackedPrayersForDay(DateFormat('yyyy-MM-dd').format(currDate));

      prayersList.add(
        AppPrayerTime(
          prayerName: "Fajr",
          prayerTime: prayerTimes!.fajr,
          isPrayed: prayedPrayers.any((x) => (x.Prayer_Name == "Fajr" && x.Is_Prayed == true)),
          isCurrent: _currentPrayerTime.compareTo(prayerTimes.fajr) == 0,
        ),
      );
      prayersList.add(
        AppPrayerTime(
          prayerName: "Dhuhr",
          prayerTime: prayerTimes.dhuhr,
          isPrayed: prayedPrayers.any((x) => (x.Prayer_Name == "Dhuhr" && x.Is_Prayed == true)),
          isCurrent: _currentPrayerTime.compareTo(prayerTimes.dhuhr) == 0,
        ),
      );
      prayersList.add(
        AppPrayerTime(
          prayerName: "Asr",
          prayerTime: prayerTimes.asr,
          isPrayed: prayedPrayers.any((x) => (x.Prayer_Name == "Asr" && x.Is_Prayed == true)),
          isCurrent: _currentPrayerTime.compareTo(prayerTimes.asr) == 0,
        ),
      );
      prayersList.add(
        AppPrayerTime(
          prayerName: "Maghrib",
          prayerTime: prayerTimes.maghrib,
          isPrayed: prayedPrayers.any((x) => (x.Prayer_Name == "Maghrib" && x.Is_Prayed == true)),
          isCurrent: _currentPrayerTime.compareTo(prayerTimes.maghrib) == 0,
        ),
      );
      prayersList.add(
        AppPrayerTime(
          prayerName: "Isha",
          prayerTime: prayerTimes.isha,
          isPrayed: prayedPrayers.any((x) => (x.Prayer_Name == "Isha" && x.Is_Prayed == true)),
          isCurrent: _currentPrayerTime.compareTo(prayerTimes.isha) == 0,
        ),
      );
      prayersList.add(
        AppPrayerTime(
          prayerName: "Sunrise",
          prayerTime: prayerTimes.sunrise,
          isPrayed: false,
          isCurrent: _currentPrayerTime.compareTo(prayerTimes.sunrise) == 0,
        ),
      );

      Dates.add((currDate, hijriDate, prayersList));
    }
  }

  Future<void> shareNextPrayer() async {
    bool isToday = true;
    bool displayGetReadyMessage = true;
    var minsToPrayer = DateTime.now().difference(NextPrayerTime).inMinutes.abs();
    var timeToPrayer = "$minsToPrayer minutes";

    if (DateTime.now().day != NextPrayerTime.day) {
      isToday = false;
    }

    if (minsToPrayer > 30) {
      displayGetReadyMessage = false;
      timeToPrayer = "${minsToPrayer ~/ 60} hours and ${minsToPrayer % 60} minutes";
    }

    var textToShare =
        "${displayGetReadyMessage ? "Get ready! " : ""}$NextPrayerName ${isToday ? "today" : "tomorrow"} is at ${DateFormat('h:mm a').format(NextPrayerTime)} (in approximately $timeToPrayer).\n\nShared using ${AppConstants.ApplicationName} app.";

    await Share.share(textToShare, subject: "Prayer time!");
  }
}

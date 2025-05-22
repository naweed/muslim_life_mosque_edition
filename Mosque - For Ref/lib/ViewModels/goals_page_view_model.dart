import 'package:event_bus/event_bus.dart';
import 'package:intl/intl.dart';
import 'package:muslimlife/Events/prayer_status_event.dart';
import 'package:muslimlife/Helpers/prayer_times_helper.dart';
import 'package:muslimlife/Models/prayer_models.dart';
import 'package:muslimlife/Shared/app_session.dart';
import 'package:muslimlife/ViewModels/app_view_model.dart';

class GoalsPageViewModel extends AppViewModel {
  final EventBus eventBus;

  DateTime? FirstPrayerDate = DateTime(2025, 1, 1);

  int TodaysPrayerCount = 0;
  int TotalPrayersThisMonth = 0;
  int TotalPrayedThisMonth = 0;
  int TotalPrayersThisYear = 0;
  int TotalPrayedThisYear = 0;
  int TotalPrayersAll = 0;
  int TotalPrayedAll = 0;

  List<PrayerNameCount> Last7DaysPrayers = [
    PrayerNameCount("Fajr", 0),
    PrayerNameCount("Dhuhr", 0),
    PrayerNameCount("Asr", 0),
    PrayerNameCount("Maghrib", 0),
    PrayerNameCount("Isha", 0),
  ];

  GoalsPageViewModel(this.eventBus) : super() {
    Title = "Prayer Statistics";

    //Listen to PrayerStatusEvent
    eventBus.on<PrayerStatusEvent>().listen((event) {
      loadData();
    });
  }

  Future<void> loadData() async {
    var todaysDate = DateTime.now();

    //Reset counters
    TodaysPrayerCount = 0;

    TotalPrayersThisMonth = 0;
    TotalPrayedThisMonth = 0;
    TotalPrayersThisYear = 0;
    TotalPrayedThisYear = 0;
    TotalPrayersAll = 0;
    TotalPrayedAll = 0;

    for (var prayerCount in Last7DaysPrayers) {
      prayerCount.PrayerCount = 0;
    }

    //Get First Date
    var firstPrayerDateFromDatabase = await appDatabaseService.getFirstDate();
    FirstPrayerDate =
        firstPrayerDateFromDatabase.isAfter(AppSession.AppStartDate!)
            ? AppSession.AppStartDate
            : firstPrayerDateFromDatabase;

    //Get Current Prayer for Today
    var todayPrayerTimes = await PrayerTimesHelper.getPrayerTimes(todaysDate);
    var (currentPrayerName, _) = await PrayerTimesHelper.getCurrentPrayer(todayPrayerTimes!, todaysDate);

    var totalPrayersToday = switch (currentPrayerName) {
      "Fajr" => 1,
      "Dhuhr" => 2,
      "Asr" => 3,
      "Maghrib" => 4,
      "Isha" => 5,
      _ => 0,
    };

    //Get Today's Prayed Count
    var todaysPrayed = await appDatabaseService.getTrackedPrayersForDay(
      DateFormat('yyyy-MM-dd').format(DateTime.now()),
    );
    TodaysPrayerCount = todaysPrayed.where((x) => x.Is_Prayed == true).length;

    // Get Last 7 Days Prayer Count
    var last7DaysPrayed = await appDatabaseService.getPrayerCountsLast7Days();

    last7DaysPrayed.forEach((prayerName, count) {
      Last7DaysPrayers.where((x) => x.PrayerName == prayerName).first.PrayerCount = count;
    });

    //Get Total Prayers
    TotalPrayersAll = todaysDate.difference(FirstPrayerDate!).inDays * 5 + totalPrayersToday;
    TotalPrayedAll =
        (await appDatabaseService.getPrayersCountBetweenDates(FirstPrayerDate!, todaysDate)) + TodaysPrayerCount;

    //Get This Month Prayers
    var firstDateForThisMonth =
        FirstPrayerDate!.isAfter(DateTime(todaysDate.year, todaysDate.month, 1))
            ? FirstPrayerDate!
            : DateTime(todaysDate.year, todaysDate.month, 1);

    TotalPrayersThisMonth = todaysDate.difference(firstDateForThisMonth).inDays * 5 + totalPrayersToday;
    TotalPrayedThisMonth =
        (await appDatabaseService.getPrayersCountBetweenDates(firstDateForThisMonth, todaysDate)) + TodaysPrayerCount;

    //Get This Year Prayers
    var firstDateForThisYear =
        FirstPrayerDate!.isAfter(DateTime(todaysDate.year, 1, 1)) ? FirstPrayerDate! : DateTime(todaysDate.year, 1, 1);

    TotalPrayersThisYear = todaysDate.difference(firstDateForThisYear).inDays * 5 + totalPrayersToday;
    TotalPrayedThisYear =
        (await appDatabaseService.getPrayersCountBetweenDates(firstDateForThisYear, todaysDate)) + TodaysPrayerCount;

    DataLoaded = true;
    rebuildUi();
  }
}

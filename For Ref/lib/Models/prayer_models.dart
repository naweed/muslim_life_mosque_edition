class AppPrayerTime {
  String prayerName;
  DateTime prayerTime;
  bool isPrayed;
  bool isCurrent;

  AppPrayerTime({required this.prayerName, required this.prayerTime, required this.isPrayed, required this.isCurrent});
}

class PrayerNameCount {
  String PrayerName;
  int PrayerCount;

  PrayerNameCount(this.PrayerName, this.PrayerCount);
}

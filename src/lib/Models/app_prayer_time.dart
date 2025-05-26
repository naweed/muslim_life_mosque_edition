import 'package:intl/intl.dart';

class AppPrayerTime {
  String prayerName;
  DateTime prayerTime;
  bool isCurrent;
  bool isNext;

  String get prayerTimeDisplay => DateFormat('hh:mm').format(prayerTime);

  AppPrayerTime({required this.prayerName, required this.prayerTime, required this.isCurrent, required this.isNext});
}

import 'package:intl/intl.dart';

class AppPrayerTime {
  String prayerName;
  DateTime prayerTime;
  bool isCurrent;
  bool isNext;
  DateTime iqamaTime;

  String get prayerTimeDisplay => DateFormat('hh:mm').format(prayerTime);
  String get iqamaTimeDisplay => DateFormat('hh:mm').format(iqamaTime);

  AppPrayerTime({
    required this.prayerName,
    required this.prayerTime,
    required this.isCurrent,
    required this.isNext,
    required this.iqamaTime,
  });
}
